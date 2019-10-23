Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9BE1B14
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391676AbfJWMoP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 08:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391648AbfJWMoP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 08:44:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NCi1DE051998
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 08:44:14 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtnjs4115-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 08:44:12 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-api@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 23 Oct 2019 13:44:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 13:44:02 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NCi11c53739520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 12:44:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FA52A405B;
        Wed, 23 Oct 2019 12:44:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 624A9A405C;
        Wed, 23 Oct 2019 12:44:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.8.55])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Oct 2019 12:44:00 +0000 (GMT)
Date:   Wed, 23 Oct 2019 15:43:58 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Andrey Vagin <avagin@gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CALCETrX=1XUwsuKc6dinj3ZTnrK85m_+UL=iaYKj4EZtf-xm5g@mail.gmail.com>
 <20191023072920.GF12121@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023072920.GF12121@uranus.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19102312-0012-0000-0000-0000035C1EB4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102312-0013-0000-0000-000021974D4F
Message-Id: <20191023124358.GA2109@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230131
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 10:29:20AM +0300, Cyrill Gorcunov wrote:
> On Tue, Oct 22, 2019 at 09:11:04PM -0700, Andy Lutomirski wrote:
> > Trying again.  It looks like I used the wrong address for Pavel.
> 
> Thanks for CC Andy! I must confess I didn't dive into userfaultfd engine
> personally but let me CC more people involved from criu side. (overquoting
> left untouched for their sake).

Thanks for CC Cyrill!

 
> > On Sat, Oct 12, 2019 at 6:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > [adding more people because this is going to be an ABI break, sigh]
> > >
> > > On Sat, Oct 12, 2019 at 5:52 PM Daniel Colascione <dancol@google.com> wrote:
> > > >
> > > > On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > >
> > > > > On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> > > > > >
> > > > > > The new secure flag makes userfaultfd use a new "secure" anonymous
> > > > > > file object instead of the default one, letting security modules
> > > > > > supervise userfaultfd use.
> > > > > >
> > > > > > Requiring that users pass a new flag lets us avoid changing the
> > > > > > semantics for existing callers.
> > > > >
> > > > > Is there any good reason not to make this be the default?
> > > > >
> > > > >
> > > > > The only downside I can see is that it would increase the memory usage
> > > > > of userfaultfd(), but that doesn't seem like such a big deal.  A
> > > > > lighter-weight alternative would be to have a single inode shared by
> > > > > all userfaultfd instances, which would require a somewhat different
> > > > > internal anon_inode API.
> > > >
> > > > I'd also prefer to just make SELinux use mandatory, but there's a
> > > > nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
> > > > which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
> > > > better way to deal with it.
> > > >
> > > > Right now, when a process with a UFFD-managed VMA using
> > > > UFFD_EVENT_FORK forks, we make a new userfaultfd_ctx out of thin air
> > > > and enqueue it on the message queue for the parent process. When we
> > > > dequeue that context, we get to resolve_userfault_fork, which makes up
> > > > a new UFFD file object out of thin air in the context of the reading
> > > > process. Following normal SELinux rules, the SID attached to that new
> > > > file object would be the task SID of the process *reading* the fork
> > > > event, not the SID of the new fork child. That seems wrong, because
> > > > the label we give to the UFFD should correspond to the label of the
> > > > process that UFFD controls.

I must admit I have no idea about how SELinux works, but what's wrong with
making the new UFFD object to inherit the properties of the "original" one?

The new file object is created in the context of the same task that owns
the initial userfault file descriptor and it is used by the same task. So
if you have a process that registers some of its VMAs with userfaultfd
and enables UFFD_EVENT_FORK, the same process controls UFFD of itself and
its children.

> > >
> > > ...
> > >
> > > > But maybe we can go further: let's separate authentication and
> > > > authorization, as we do in other LSM hooks. Let's split my
> > > > inode_init_security_anon into two hooks, inode_init_security_anon and
> > > > inode_create_anon. We'd define the former to just initialize the file
> > > > object's security information --- in the SELinux case, figuring out
> > > > its class and SID --- and define the latter to answer the yes/no
> > > > question of whether a particular anonymous inode creation should be
> > > > allowed. Normally, anon_inode_getfile2() would just call both hooks.
> > > > We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
> > > > or something, that would tell anon_inode_getfile2() to skip calling
> > > > the authorization hook, effectively making the creation always
> > > > succeed. We can then make the UFFD code pass
> > > > ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
> > > > fork child while creating UFFD_EVENT_FORK messages.
> > >
> > > That sounds like an improvement.  Or maybe just teach SELinux that
> > > this particular fd creation is actually making an anon_inode that is a
> > > child of an existing anon inode and that the context should be copied
> > > or whatever SELinux wants to do.  Like this, maybe:
> > >
> > > static int resolve_userfault_fork(struct userfaultfd_ctx *ctx,
> > >                                   struct userfaultfd_ctx *new,
> > >                                   struct uffd_msg *msg)
> > > {
> > >         int fd;
> > >
> > > Change this:
> > >
> > >         fd = anon_inode_getfd("[userfaultfd]", &userfaultfd_fops, new,
> > >                               O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS));
> > >
> > > to something like:
> > >
> > >       fd = anon_inode_make_child_fd(..., ctx->inode, ...);
> > >
> > > where ctx->inode is the one context's inode.
> > >
> > > *** HOWEVER *** !!!
> > >
> > > Now that you've pointed this mechanism out, it is utterly and
> > > completely broken and should be removed from the kernel outright or at
> > > least severely restricted.  A .read implementation MUST NOT ACT ON THE
> > > CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> > > as stdin to a setuid program.
> > >
> > > So I think the right solution might be to attempt to *remove*
> > > UFFD_EVENT_FORK.  Maybe the solution is to say that, unless the
> > > creator of a userfaultfd() has global CAP_SYS_ADMIN, then it cannot
> > > use UFFD_FEATURE_EVENT_FORK) and print a warning (once) when
> > > UFFD_FEATURE_EVENT_FORK is allowed.  And, after some suitable
> > > deprecation period, just remove it.  If it's genuinely useful, it
> > > needs an entirely new API based on ioctl() or a syscall.  Or even
> > > recvmsg() :)
> > >
> > > And UFFD_SECURE should just become automatic, since you don't have a
> > > problem any more. :-p
> > >
> > > --Andy
> > 
> 
> 	Cyrill

-- 
Sincerely yours,
Mike.

