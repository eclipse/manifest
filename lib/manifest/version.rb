###############################################################################
# Copyright (c) 2008-2009 Manifest and others.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     Antoine Toulme - initial API and implementation
###############################################################################

module Manifest #:nodoc:
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 7

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
end
