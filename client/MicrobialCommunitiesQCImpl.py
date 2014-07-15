#BEGIN_HEADER
#END_HEADER

'''

Module Name:
MicrobialCommunitiesQC

Module Description:
RESTful Microbial Communities object and resource API

'''
class MicrobialCommunitiesQC:

    #BEGIN_CLASS_HEADER
    #END_CLASS_HEADER

    def __init__(self, config): #config contains contents of config file in hash or 
                                #None if it couldn't be found
        #BEGIN_CONSTRUCTOR
        #END_CONSTRUCTOR
        pass

    def get_drisee_compute(self, GetDriseeComputeParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_drisee_compute
        #END get_drisee_compute

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_drisee_compute return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
    def get_drisee_instance(self, GetDriseeInstanceParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_drisee_instance
        #END get_drisee_instance

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_drisee_instance return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
    def get_histogram_compute(self, GetHistogramComputeParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_histogram_compute
        #END get_histogram_compute

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_histogram_compute return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
    def get_histogram_instance(self, GetHistogramInstanceParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_histogram_instance
        #END get_histogram_instance

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_histogram_instance return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
    def get_kmer_compute(self, GetKmerComputeParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_kmer_compute
        #END get_kmer_compute

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_kmer_compute return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
    def get_kmer_instance(self, GetKmerInstanceParams):
        # self.ctx is set by the wsgi application class
        # return variables are: returnVal
        #BEGIN get_kmer_instance
        #END get_kmer_instance

        #At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method get_kmer_instance return value returnVal is not type dict as required.')
        # return the results
        return [ returnVal ]
        
