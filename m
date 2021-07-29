Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DF73DA111
	for <lists+linux-api@lfdr.de>; Thu, 29 Jul 2021 12:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhG2Kaf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Jul 2021 06:30:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235741AbhG2Kae (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Jul 2021 06:30:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TA9XjQ074133;
        Thu, 29 Jul 2021 06:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=kG7qmPC0mpWciXBythR6/76yhYJ60bZKI/NnBaPlVcg=;
 b=hR1u1GL9YLpomT2FS/SoHbUG3QRbjyF/MT271G/v2Tg9wcjvTPXdNybX1EbjSKy8yufL
 XUj7qO8gvFAC6fL9uP8/PF5EsUMUSdFNnqzU0hdYZ+dvKGM3XA2GdBIpE96P39Q+4udB
 pa4W91BWRRgfXBDxdlia/bd/3luksZYOG9d8EPFCW1xwiJk0KS0GSE4hak+AugxWrlrY
 kaGsRah7Vz9WIU3OWslZnrGuXoboQw0VG4BQrfnU2cwYa9LvzrJ7lt9SJ9JmUUt1Zpqi
 hkx8bJhSxEfdIfzyp0YYEMe5QthwYooFSs5UbOyB9r9E1J1+AFqkpchIpvS7Lm3wh5n3 BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3qrjq2sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:30:29 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TA9bxX074550;
        Thu, 29 Jul 2021 06:30:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3qrjq2rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:30:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TAROvf021422;
        Thu, 29 Jul 2021 10:30:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m1mp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 10:30:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TAUOc626607994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 10:30:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8E884C058;
        Thu, 29 Jul 2021 10:30:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2282D4C040;
        Thu, 29 Jul 2021 10:30:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.86.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Jul 2021 10:30:23 +0000 (GMT)
Date:   Thu, 29 Jul 2021 13:30:20 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2] man2: new page describing memfd_secret() system call
Message-ID: <YQKDPMmyKdKcqHJf@linux.ibm.com>
References: <20210729082900.1581359-1-rppt@kernel.org>
 <3572b371-80ab-eac1-e2c5-26b07748f767@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3572b371-80ab-eac1-e2c5-26b07748f767@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7t0Hs_ox8908HUzsk7u_Wh99JHMgHuPy
X-Proofpoint-ORIG-GUID: iVOSCbM7ojFlC7al4ZmYn23SMy0N8lob
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_09:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290061
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 29, 2021 at 12:12:12PM +0200, Alejandro Colomar (man-pages) wrote:
> Hi Mike,
> 
> On 7/29/21 10:29 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> > 
> > v2: address Alex's comments:
> > * update synopsis to match new style for syscalls without a wrapper
> > * drop note about absence of glibc wrapper
> > * update formatting
> 
> Please check a small typo introduced in v2 below.
> 
> Thanks!
> 
> Alex
> 
> > 
> > v1: https://lore.kernel.org/linux-api/20210727124140.1487079-1-rppt@kernel.org
> > 
> >   man2/memfd_secret.2 | 147 ++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 147 insertions(+)
> >   create mode 100644 man2/memfd_secret.2
> > 
> > diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
> > new file mode 100644
> > index 000000000..5a70cb5d2
> > --- /dev/null
> > +++ b/man2/memfd_secret.2
> > @@ -0,0 +1,147 @@
> > +.\" Copyright (c) 2021, IBM Corporation.
> > +.\" Written by Mike Rapoport <rppt@linux.ibm.com>
> > +.\"
> > +.\" Based on memfd_create(2) man page
> > +.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
> > +.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
> > +.\"
> > +.\" %%%LICENSE_START(GPLv2+)
> > +.\"
> > +.\" This program is free software; you can redistribute it and/or modify
> > +.\" it under the terms of the GNU General Public License as published by
> > +.\" the Free Software Foundation; either version 2 of the License, or
> > +.\" (at your option) any later version.
> > +.\"
> > +.\" This program is distributed in the hope that it will be useful,
> > +.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > +.\" GNU General Public License for more details.
> > +.\"
> > +.\" You should have received a copy of the GNU General Public
> > +.\" License along with this manual; if not, see
> > +.\" <http://www.gnu.org/licenses/>.
> > +.\" %%%LICENSE_END
> > +.\"
> > +.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
> > +.SH NAME
> > +memfd_secret \- create an anonymous file to access secret memory regions
> > +.SH SYNOPSIS
> > +.nf
> > +.PP
> > +.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
> > +.B #include <unistd.h>
> > +.PP
> > +.BI "int syscall(SYS_memfd_secret, int " cmd ", unsigned int " flags \
> > +", int " cpu_id );
> 
> Check the parameter list :)
 
Argh. 

Would you need v3 or this on top would suffice?

diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
index 5a70cb5d2..8263f18d5 100644
--- a/man2/memfd_secret.2
+++ b/man2/memfd_secret.2
@@ -31,8 +31,7 @@ memfd_secret \- create an anonymous file to access secret memory regions
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
-.BI "int syscall(SYS_memfd_secret, int " cmd ", unsigned int " flags \
-", int " cpu_id );
+.BI "int syscall(SYS_memfd_secret, unsigned int " flags ");
 .fi
 .PP
 .IR Note :

-- 
Sincerely yours,
Mike.
