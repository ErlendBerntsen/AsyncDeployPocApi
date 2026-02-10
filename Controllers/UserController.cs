using ApiExample.Models;
using Microsoft.AspNetCore.Mvc;

namespace ApiExample.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {

        [HttpGet]
        public User Get()
        {
            return new User
            {
                Name = "Erlend Berntsen"
            };
        }

    }
}
