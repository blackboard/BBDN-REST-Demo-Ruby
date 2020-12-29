require 'rest-client'
require 'json'

$HOSTNAME = 'https://devcon.blackboard.com'
$KEY = 'd03caa33-1095-47b9-bc67-f5cd634430b1'
$SECRET = 'QSFClAMu5KmoG8yFbHTi7pjhsseJl4uz'


$AUTH_PATH = $HOSTNAME + '/learn/api/public/v1/oauth2/token';
$DSK_PATH = $HOSTNAME + '/learn/api/public/v1/dataSources/';
$TERM_PATH = $HOSTNAME + '/learn/api/public/v1/terms/';
$COURSE_PATH = $HOSTNAME + '/learn/api/public/v1/courses/';
$USER_PATH = $HOSTNAME + '/learn/api/public/v1/users/';

$access_token = ''
$dsk_id = ''
$term_id = ''
$course_id = ''
$user_id = ''
$membership_id = ''
$auth = ''

bb_rest = RestClient::Resource.new $AUTH_PATH, $KEY, $SECRET
  
begin
  bb_rest.post('grant_type=client_credentials', :accept => :json){ |response, request, result, &block|
  case response.code
   when 200
     p "It worked !"
     token = JSON.parse(response)
     $access_token = token['access_token']
     $auth = "Bearer " + $access_token
     p 'Access_Token: ' + $access_token 
   else
    p response.to_s
    response.return!(request, result, &block)
   end
  }

  payload = "{ \"externalId\":\"BBDN-DSK-RUBY\", \"description\": \"Demo Data Source used for REST Ruby Demo\" }"

  RestClient.post($DSK_PATH, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
  case response.code
    when 201
      p "It worked !"
      datasource = JSON.parse(response)
      $dsk_id = datasource['id']
      p 'Create Datasource: dsk_id=' + $dsk_id
    else
      p response.to_s
      response.return!(request, result, &block)
    end
  }
  
  payload = "{ \"externalId\":\"BBDN-TERM-RUBY\", \"dataSourceId\":\"" + $dsk_id + "\", \"name\" : \"REST Demo Term - Ruby\", \"description\": \"Term Used For REST Demo - Ruby\", \"availability\" : { \"available\" : \"Yes\" } }"

    RestClient.post($TERM_PATH, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
    case response.code
      when 201
        p "It worked !"
        term = JSON.parse(response)
        $term_id = term['id']
        p 'Create Term: term_id=' + $term_id
      else
        p response.to_s
        response.return!(request, result, &block)
      end
    }

  payload = "{ \"externalId\" : \"BBDN-Java-Ruby-Demo\", \"courseId\" : \"BBDN-Java-Ruby-Demo\", \"name\" : \"Course Used For REST Demo - Ruby\", \"description\" : \"Course Used For REST Demo - Ruby\", \"allowGuests\" : \"true\", \"readOnly\" : \"false\", \"termId\" : \"" + $term_id + "\", \"dataSourceId\" : \"" + $dsk_id + "\", \"availability\" : { \"available\" : \"Yes\" } }"

    RestClient.post($COURSE_PATH, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
    case response.code
      when 201
        p "It worked !"
        course = JSON.parse(response)
        $course_id = course['id']
        p 'Create Course: course_id=' + $course_id
      else
        p response.to_s
        response.return!(request, result, &block)
      end
    }
    
  payload = "{ \"externalId\" : \"bbdnrestdemorubyuser\", \"userName\" : \"restrubyuser\", \"password\" : \"Bl@ckb0ard!\", \"studentId\" : \"restrubyuser\", \"dataSourceId\" : \"" + $dsk_id + "\", \"name\" : { \"given\" : \"Ruby\", \"family\" : \"Rest Demo\" }, \"contact\" : { \"email\" : \"developers@blackboard.com\" }, \"availability\" : { \"available\" : \"Yes\" } }"
  
      RestClient.post($USER_PATH, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
      case response.code
        when 201
          p "It worked !"
          user = JSON.parse(response)
          $user_id = user['id']
          p 'Create User: user_id=' + $user_id
        else
          p response.to_s
          response.return!(request, result, &block)
        end
      }
    
  payload = "{ \"courseRoleId\" : \"Student\", \"dataSourceId\" : \"" + $dsk_id + "\", \"availability\" : { \"available\" : \"Yes\" } }"

  
      RestClient.put($COURSE_PATH + $course_id + '/users/' + $user_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
      case response.code
        when 201
          p "It worked !"
          membership = JSON.parse(response)
          $created = membership['created']
          p 'Create Membership: ' + $created
        else
          p response.to_s
          response.return!(request, result, &block)
        end
      }
       
  
  RestClient.get($DSK_PATH + $dsk_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
           case response.code
             when 200
               p "Got Datasource !" + response.to_s
             else
               p response.to_s
               response.return!(request, result, &block)
             end
           }
           
  RestClient.get($TERM_PATH + $term_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 200
              p "Got Term !" + response.to_s
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
           
  RestClient.get($COURSE_PATH + $course_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 200
              p "Got Course !" + response.to_s
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
          
  RestClient.get($USER_PATH + $user_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
            case response.code
              when 200
                p "Got User !" + response.to_s
              else
                p response.to_s
                response.return!(request, result, &block)
              end
            }          
  RestClient.get($COURSE_PATH + $course_id + '/users/' + $user_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 200
              p "Got Membership !" + response.to_s
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }

  
  payload = "{ \"externalId\":\"BBDN-DSK-RUBY\", \"description\": \"Demo Data Source used for REST Ruby Demo - Updated\" }"
  
    RestClient.patch($DSK_PATH + $dsk_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
    case response.code
      when 200
        p 'Updated Datasource: ' + response.to_s
      else
        p response.to_s
        response.return!(request, result, &block)
      end
    }
    
  payload = "{ \"externalId\":\"BBDN-TERM-RUBY\", \"dataSourceId\":\"" + $dsk_id + "\", \"name\" : \"REST Demo Term - Ruby\", \"description\": \"Updated Term Used For REST Demo - Ruby\", \"availability\" : { \"available\" : \"Yes\" } }"

    RestClient.patch($TERM_PATH + $term_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
    case response.code
      when 200
        p 'Updated Term: ' + response.to_s
      else
        p response.to_s
        response.return!(request, result, &block)
      end
    }

  payload = "{ \"externalId\" : \"BBDN-Java-Ruby-Demo\", \"courseId\" : \"BBDN-Java-Ruby-Demo\", \"name\" : \"Course Used For REST Demo - Ruby\", \"description\" : \"Updated Course Used For REST Demo - Ruby\", \"allowGuests\" : \"false\", \"readOnly\" : \"false\", \"termId\" : \"" + $term_id + "\", \"dataSourceId\" : \"" + $dsk_id + "\", \"availability\" : { \"available\" : \"Yes\" } }"

    RestClient.patch($COURSE_PATH + $course_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
    case response.code
      when 200
      p 'Updated Course: ' + response.to_s
      else
        p response.to_s
        response.return!(request, result, &block)
      end
    }
    
  payload = "{ \"externalId\" : \"bbdnrestdemorubyuser\", \"userName\" : \"restrubyuser\", \"password\" : \"Bl@ckb0ard!\", \"studentId\" : \"restrubyuser\", \"dataSourceId\" : \"" + $dsk_id + "\", \"name\" : { \"given\" : \"Ruby\", \"family\" : \"Rest Demo\", \"middle\" : \"updated\" }, \"contact\" : { \"email\" : \"developers@blackboard.com\" }, \"availability\" : { \"available\" : \"Yes\" } }"
  
      RestClient.patch($USER_PATH + $user_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
      case response.code
        when 200
        p 'Updated User: ' + response.to_s
        else
          p response.to_s
          response.return!(request, result, &block)
        end
      }
    
  payload = "{ \"userId\" : \"" + $user_id + "\", \"courseId\" : \"" + $course_id + "\", \"courseRoleId\" : \"Instructor\", \"dataSourceId\" : \"" + $dsk_id + "\", \"availability\" : { \"available\" : \"Yes\" } }"

  
      RestClient.patch($COURSE_PATH + $course_id + '/users/' + $user_id, payload, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
      case response.code
        when 200
        p 'Updated Membership: ' + response.to_s
        else
          p response.to_s
          response.return!(request, result, &block)
        end
      }
          
          
              
  RestClient.delete($COURSE_PATH + $course_id + '/users/' + $user_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
        case response.code
          when 204
            p "Membership Deleted !"
          else
            p response.to_s
            response.return!(request, result, &block)
          end
        }
        
  
  RestClient.delete($USER_PATH + $user_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 204
              p "User Deleted !"
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
          

  RestClient.delete($COURSE_PATH + $course_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 204
              p "Course Deleted !"
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
          
          
  RestClient.delete($TERM_PATH + $term_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 204
              p "Term Deleted !"
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
          
          
          
  RestClient.delete($DSK_PATH + $dsk_id, :content_type => :json, :accept => :json, :Authorization => $auth){ |response, request, result, &block|
          case response.code
            when 204
              p "Datasource Deleted !"
            else
              p response.to_s
              response.return!(request, result, &block)
            end
          }
      
end