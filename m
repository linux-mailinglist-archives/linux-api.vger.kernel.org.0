Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173EFE54E9
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 22:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJYUMz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 16:12:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbfJYUMz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 16:12:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PKC3rp016118
        for <linux-api@vger.kernel.org>; Fri, 25 Oct 2019 16:12:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv7n98g6d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Fri, 25 Oct 2019 16:12:54 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 25 Oct 2019 21:12:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 21:12:47 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PKCkce60948514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 20:12:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A351B5204F;
        Fri, 25 Oct 2019 20:12:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.205.37])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 54F7C5204E;
        Fri, 25 Oct 2019 20:12:45 +0000 (GMT)
Date:   Fri, 25 Oct 2019 23:12:43 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com>
 <20191024090258.GA9802@linux.ibm.com>
 <20191024151054.GJ9902@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024151054.GJ9902@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19102520-0016-0000-0000-000002BDA4DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102520-0017-0000-0000-0000331EF01D
Message-Id: <20191025201242.GA8710@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=747 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250184
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

On Thu, Oct 24, 2019 at 11:10:54AM -0400, Andrea Arcangeli wrote:
> Hello,
> 
> On Thu, Oct 24, 2019 at 12:02:59PM +0300, Mike Rapoport wrote:
> > That's no the reason that UFFD_FEATURE_EVENT_FORK does not show up in
> > Debian code search, CRIU simply is not there. Debian packages CRIU only in
> > experimental and I believe that's not indexed by the code search.
> > 
> > As for the limitations, the races were fixed, I just forgot to update the
> > wiki. As for the supported memory types and COW pages, these only affect
> > efficiency of post-copy, but not the correctness.
> 
> That's what I was hoping for. If the wiki information is stale and
> there are no races it is totally plausible that it's being actively
> used in production so we need to fix the kernel bug. I was just
> checking because I wasn't sure anymore of the status after I read the
> wiki.
> 
> If the CRIU initialization code that issues the uffd syscall runs as
> global root the ABI breaking permission check from Andy sounds the
> simplest for a short term fix, because it will be unnoticed by any
> production usage with CIRU --lazy-pages.
 
In general, criu can run as non-root, but such use of criu has limitations,
so allowing criu --lazy-pages only for root sounds reasonable as a short
term solution.

> Then later we could add a UFFD_FEATURE_EVENT_FORK2 that will not
> require root permission.

Agree.

> Thanks,
> Andrea
> 

-- 
Sincerely yours,
Mike.

