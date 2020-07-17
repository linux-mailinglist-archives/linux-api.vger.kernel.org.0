Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9A223E80
	for <lists+linux-api@lfdr.de>; Fri, 17 Jul 2020 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQOo0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jul 2020 10:44:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgGQOo0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jul 2020 10:44:26 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HEUmGP056868;
        Fri, 17 Jul 2020 10:43:59 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32b61k6jhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 10:43:58 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06HEeAsW001138;
        Fri, 17 Jul 2020 14:43:58 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 32752a5vre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 14:43:58 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06HEhsdp2425390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 14:43:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 878AB78060;
        Fri, 17 Jul 2020 14:43:56 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E9D78067;
        Fri, 17 Jul 2020 14:43:53 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.141.100])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jul 2020 14:43:53 +0000 (GMT)
Message-ID: <1594997031.3344.27.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/5] mm: extend memfd with ability to create
 "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Pavel Machek <pavel@ucw.cz>, Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Date:   Fri, 17 Jul 2020 07:43:51 -0700
In-Reply-To: <20200717083601.GB1027@bug>
References: <20200706172051.19465-1-rppt@kernel.org>
         <20200717083601.GB1027@bug>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_06:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 lowpriorityscore=0
 spamscore=100 clxscore=1011 bulkscore=0 mlxlogscore=-1000 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxscore=100 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170103
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 2020-07-17 at 10:36 +0200, Pavel Machek wrote:
> Hi!
> 
> > This is a second version of "secret" mappings implementation backed
> > by a file descriptor. 
> > 
> > The file descriptor is created using memfd_create() syscall with a
> > new MFD_SECRET flag. The file descriptor should be configured using
> > ioctl() to define the desired protection and then mmap() of the fd
> > will create a "secret" memory mapping. The pages in that mapping
> > will be marked as not present in the direct map and will have
> > desired protection bits set in the user page table. For instance,
> > current implementation allows uncached mappings.
> > 
> > Hiding secret memory mappings behind an anonymous file allows
> > (ab)use of the page cache for tracking pages allocated for the
> > "secret" mappings as well as using address_space_operations for
> > e.g. page migration callbacks.
> > 
> > The anonymous file may be also used implicitly, like hugetlb files,
> > to implement mmap(MAP_SECRET) and use the secret memory areas with
> > "native" mm ABIs.
> 
> I believe unix userspace normally requires mappings to be... well...
> protected from other users. How is this "secret" thing different? How
> do you explain the difference to userland programmers?

That's true in the normal case, but for the container cloud the threat
model we're considering is a hostile other tenant trying to trick the
kernel into giving them access to your mappings.  In the FOSDEM talk we
did about this:

https://fosdem.org/2020/schedule/event/kernel_address_space_isolation/

We demonstrated the case where the hostile tenant obtained host root
and then tried to get access via ptrace.  The point being that pushing
the pages out of the direct map means that even root can't get access
to the secret by any means the OS provides.  If you want to play with
this yourself, we have a userspace library:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git/

It does two things: the first is act as a preloader for openssl to
redirect all the OPENSSL_malloc calls to secret memory meaning any
secret keys get automatically protected this way and the other thing it
does is expose the API to the user who needs it.  I anticipate that a
lot of the use cases would be like the openssl one: many toolkits that
deal with secret keys already have special handling for the memory to
try to give them greater protection, so this would simply be pluggable
into the toolkits without any need for user application modification.

James

