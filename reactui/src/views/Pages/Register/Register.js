import React, {Component} from "react";
import {NavLink} from "react-router-dom";
import {Container, Row, Col, Card, CardBlock, CardFooter, Button, Input, InputGroup, InputGroupAddon} from "reactstrap";

class Register extends Component {
  render() {
    return (
      <div className = "animated fadeIn">
        <div className="app flex-row align-items-center">
          <Container>
            <Row className="justify-content-center">
              <Col md="6">
                <Card className="mx-4">
                  <CardBlock className="card-body p-4">
                    <h1>Add Item</h1>
                    <p className="text-muted">Add new passport</p>
                  <InputGroup className="mb-3">
                    <Input type="text" placeholder="Passport ID"/>
                  </InputGroup>
                  <InputGroup className="mb-3">
                    <Input type="text" placeholder="Name"/>
                  </InputGroup>
                  <InputGroup className="mb-3">
                    <Input type="text" placeholder="Date of Birth"/>
                  </InputGroup>
                  <InputGroup className="mb-3">
                    <Input type="text" placeholder="Date Issued"/>
                  </InputGroup>
                      
                          <NavLink to="/dashboard">
                            <Button color="success" block>
                              Add Item
                            </Button>
                          </NavLink>
                  </CardBlock>

                </Card>
              </Col>
            </Row>
          </Container>
        </div>
      </div>
    );
  }
}

export default Register;
