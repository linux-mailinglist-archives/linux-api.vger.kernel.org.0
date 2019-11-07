Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA5F30D5
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 15:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfKGOGD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 09:06:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGOGD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 09:06:03 -0500
Received: from p2e5857ae.dip0.t-ipconnect.de ([46.88.87.174] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iSiQC-0004mh-JH; Thu, 07 Nov 2019 14:06:00 +0000
Date:   Thu, 7 Nov 2019 15:05:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Elichai Turkel <elichai.turkel@gmail.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>,
        dhowells@redhat.com
Subject: Re: Continuing the UAPI split
Message-ID: <20191107140558.kgbgnfihvmssm7sj@wittgenstein>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
 <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
 <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
 <87zhh7hlbl.fsf@oldenburg2.str.redhat.com>
 <20191107133652.lqp5cqcdtwu22ibd@wittgenstein>
 <87v9rvhk6t.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9rvhk6t.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 07, 2019 at 02:47:54PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > A problem I recently ran into that is related are problems with
> > sys/wait.h and linux/wait.h.
> > How P_{PID,PGID,PIDFD} used by the waitid() syscall are defined is
> > different for the two headers.
> > linux/wait.h uses #define for P_{PID,PGID,PIDFD} whereas sys/wait.h
> > uses an enum.
> > The problem is that if I simply don't rely on sys/wait.h and just do
> > #ifndef P_PID
> > #define P_PID <value>
> > #endif
> > where value is what the syscall expects then technically I need to call
> > the waitid() syscall directly since it's not at all guaranteed - afaict
> > - that the P_PID enum == P_PID define that glibc uses for its waitid()
> > syscall wrapper.
> 
> Right, and this is where POSIX mandates that there is a type idtype_t
> which is an enum, an that it has members P_PID etc.
> 
> What we could do is:
> 
> typedef enum
> {
>   P_ALL,		/* Wait for any child.  */
> #define P_ALL P_ALL
>   P_PID,		/* Wait for specified process.  */
> #define P_PID P_PID
>   P_PGID		/* Wait for members of process group.  */
> #define P_PGID P_PGID
> } idtype_t;

Right, that sounds feasible.
(Nit/slightly off-topic: David (forgot to Cc him...) once reminded me
 that we do prefer to explicitly set the enum value so that there are no
 accidental changes, e.g.:

typedef enum
{
  P_ALL = 0,		/* Wait for any child.  */
#define P_ALL P_ALL
  P_PID = 1,		/* Wait for specified process.  */
#define P_PID P_PID
  P_PGID = 2,		/* Wait for members of process group.  */
#define P_PGID P_PGID
  P_PIDFD = 3,		/* Wait via pidfds.  */
#define P_PIDFD P_PIDFD
} idtype_t;

)

> 
> The other header can then use #ifdef.  You'll see that pattern in some
> cases already.
> 
> But that will only work if you include glibc headers first.  The generic
> approach uses some shared macro for the coordination so that things work
> both ways.

We saw a conflict at least on Fedora for the pidfd-tests with the new
P_PIDFD type defined in linux/wait.h but not yet in sys/wait.h and it
was exactly caused by wrong inclusion order. :)

> 
> The other issue here is that it gets rather iffy from a language point
> of view if the kernel wants to add additional constants and glibc has
> still the old idtype_t definition.
> 
> > So I'm now in a scenario where I can't call the glibc wrapper for
> > waitid() with the linux/wait.h defines and I can't call the syscall
> > directly (e.g. because I want to make use of the syscall's rusage
> > argument that glibc doesn't expose) with sys/wait.h's P_PID enum.
> > I'm not sure what the right solution is here...
> 
> Yes, it's a hard problem.  waitid is particularly annoying because POSIX
> and the kernel have such different function prototypes.  We could
> perhaps expose the actual waitid system call under a different name, and

Wouldn't be the worst idea.

> use int for the ID type parameter.  But that needs someone to write a
> patch.  (My efforts to add syscall wrappers have stalled unfortunately.)

This could be a good Google Summer of Code or Outreachy project or
something tbh. In general, some more noise around this would probably
help. Especially with the ability to use Gerrit to submit patches that
might make it easier for people to contribute...
Do we officially document somewhere how to add glibc syscall wrappers?

Christian
