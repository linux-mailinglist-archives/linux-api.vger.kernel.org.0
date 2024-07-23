Return-Path: <linux-api+bounces-2020-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6A93A11E
	for <lists+linux-api@lfdr.de>; Tue, 23 Jul 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B601F22B24
	for <lists+linux-api@lfdr.de>; Tue, 23 Jul 2024 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FC152E04;
	Tue, 23 Jul 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QoxHXFmq"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C2152196
	for <linux-api@vger.kernel.org>; Tue, 23 Jul 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740609; cv=none; b=gDNCatBdzCtvkFNfRWoOrjUY2UQiaFCKDdJ5iun25D24v+yNj+IZU3WpJPUlPytSt8aetwG9a/iXO+JSvzqLsyCswkeyapgX8cSMTcIfmAH3kGuHLriLRPbYTFoFV6xzTqhz+VdYD3ntD3gUG/Qk6yGalijr26NRDN6i5yTX6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740609; c=relaxed/simple;
	bh=xEwc8PxtVvX8tsn9ZtZk7QYu/EDsOr3ij74CMnS5fEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f98sMuNfDLoSIhdWewAGPpJEfyua1p4iBTd5C7hIaOiWFGK4z5PcdiqKa8o/l7CATX6zaiyDFagyJTERtDODT4r4gJYsKhj3UACtR4rth7ooodo7/sRcTHOuENPOTcvsGHqIZIjwO4awhb/9CzzUPA41AOMIZpPscrtg1vGzHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QoxHXFmq; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WSyNF46gzzl2p;
	Tue, 23 Jul 2024 15:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721740605;
	bh=aewoPXtLEZ2GI0ABNVUxmYfgHpbPmetUh2xF9chmBvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoxHXFmq0LCFEzZK0mctxYTvHGqNZ1uCqYaYTsicvHyPtGk6/EoAvbcjptbOdletB
	 Xb+mo9w40Pve8Z4bqucnZtXJ5vuZ8LzPC439s3sEnEroIcBRqKvnRKpMP3XVQmBgwu
	 oYK6AKjw5ryx52fN9ih6Bs6OS9r5voySJS6klizc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WSyND3c4Mz7kk;
	Tue, 23 Jul 2024 15:16:44 +0200 (CEST)
Date: Tue, 23 Jul 2024 15:16:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, 
	Steve Dower <steve.dower@python.org>, Jeff Xu <jeffxu@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240723.eY8boameed1k@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org>
 <20240717.AGh2shahc9ee@digikod.net>
 <CALCETrUcr3p_APNazMro7Y9FX1zLAiQESvKZ5BDgd8X3PoCdFw@mail.gmail.com>
 <20240718.Niexoo0ahch0@digikod.net>
 <CALCETrVVq4DJZ2q9V9TMuvZ1nb+-Qf4Eu8LVBgUy3XiTa=jFCQ@mail.gmail.com>
 <D2UC8YVOX9WU.1DRD4QFQ92L1U@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D2UC8YVOX9WU.1DRD4QFQ92L1U@kernel.org>
X-Infomaniak-Routing: alpha

On Sat, Jul 20, 2024 at 02:43:41PM +0300, Jarkko Sakkinen wrote:
> On Sat Jul 20, 2024 at 4:59 AM EEST, Andy Lutomirski wrote:
> > > On Jul 18, 2024, at 8:22 PM, Mickaël Salaün <mic@digikod.net> wrote:
> > >
> > > ﻿On Thu, Jul 18, 2024 at 09:02:56AM +0800, Andy Lutomirski wrote:
> > >>>> On Jul 17, 2024, at 6:01 PM, Mickaël Salaün <mic@digikod.net> wrote:
> > >>>
> > >>> On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
> > >>>>> On 17/07/2024 07:33, Jeff Xu wrote:
> > >>>>> Consider those cases: I think:
> > >>>>> a> relying purely on userspace for enforcement does't seem to be
> > >>>>> effective,  e.g. it is trivial  to call open(), then mmap() it into
> > >>>>> executable memory.
> > >>>>
> > >>>> If there's a way to do this without running executable code that had to pass
> > >>>> a previous execveat() check, then yeah, it's not effective (e.g. a Python
> > >>>> interpreter that *doesn't* enforce execveat() is a trivial way to do it).
> > >>>>
> > >>>> Once arbitrary code is running, all bets are off. So long as all arbitrary
> > >>>> code is being checked itself, it's allowed to do things that would bypass
> > >>>> later checks (and it's up to whoever audited it in the first place to
> > >>>> prevent this by not giving it the special mark that allows it to pass the
> > >>>> check).
> > >>>
> > >>> Exactly.  As explained in the patches, one crucial prerequisite is that
> > >>> the executable code is trusted, and the system must provide integrity
> > >>> guarantees.  We cannot do anything without that.  This patches series is
> > >>> a building block to fix a blind spot on Linux systems to be able to
> > >>> fully control executability.
> > >>
> > >> Circling back to my previous comment (did that ever get noticed?), I
> > >
> > > Yes, I replied to your comments.  Did I miss something?
> >
> > I missed that email in the pile, sorry. I’ll reply separately.
> >
> > >
> > >> don’t think this is quite right:
> > >>
> > >> https://lore.kernel.org/all/CALCETrWYu=PYJSgyJ-vaa+3BGAry8Jo8xErZLiGR3U5h6+U0tA@mail.gmail.com/
> > >>
> > >> On a basic system configuration, a given path either may or may not be
> > >> executed. And maybe that path has some integrity check (dm-verity,
> > >> etc).  So the kernel should tell the interpreter/loader whether the
> > >> target may be executed. All fine.
> > >>
> > >> But I think the more complex cases are more interesting, and the
> > >> “execute a program” process IS NOT BINARY.  An attempt to execute can
> > >> be rejected outright, or it can be allowed *with a change to creds or
> > >> security context*.  It would be entirely reasonable to have a policy
> > >> that allows execution of non-integrity-checked files but in a very
> > >> locked down context only.
> > >
> > > I guess you mean to transition to a sandbox when executing an untrusted
> > > file.  This is a good idea.  I talked about role transition in the
> > > patch's description:
> > >
> > > With the information that a script interpreter is about to interpret a
> > > script, an LSM security policy can adjust caller's access rights or log
> > > execution request as for native script execution (e.g. role transition).
> > > This is possible thanks to the call to security_bprm_creds_for_exec().
> >
> > …
> >
> > > This patch series brings the minimal building blocks to have a
> > > consistent execution environment.  Role transitions for script execution
> > > are left to LSMs.  For instance, we could extend Landlock to
> > > automatically sandbox untrusted scripts.
> >
> > I’m not really convinced.  There’s more to building an API that
> > enables LSM hooks than merely sticking the hook somewhere in kernel
> > code. It needs to be a defined API. If you call an operation “check”,
> > then people will expect it to check, not to change the caller’s
> > credentials.  And people will mess it up in both directions (e.g.
> > callers will call it and then open try to load some library that they
> > should have loaded first, or callers will call it and forget to close
> > fds first.
> >
> > And there should probably be some interaction with dumpable as well.
> > If I “check” a file for executability, that should not suddenly allow
> > someone to ptrace me?
> >
> > And callers need to know to exit on failure, not carry on.
> >
> >
> > More concretely, a runtime that fully opts in to this may well "check"
> > multiple things.  For example, if I do:
> >
> > $ ld.so ~/.local/bin/some_program   (i.e. I literally execve ld.so)
> >
> > then ld.so will load several things:
> >
> > ~/.local/bin/some_program
> > libc.so
> > other random DSOs, some of which may well be in my home directory
> 
> What would really help to comprehend this patch set would be a set of
> test scripts, preferably something that you can run easily with
> BuildRoot or similar.
> 
> Scripts would demonstrate the use cases for the patch set. Then it
> would be easier to develop scripts that would underline the corner
> cases. I would keep all this out of kselftest shenanigans for now.

I'll include a toy script interpreter with the next patch series.  This
one was an RFC.

> 
> I feel that the patch set is hovering in abstractions with examples
> that you cannot execute.
> 
> I added the patches to standard test CI hack:
> 
> https://codeberg.org/jarkko/linux-tpmdd-test
> 
> But after I booted up a kernel I had no idea what to do with it. And
> all this lenghty discussion makes it even more confusing.

You can run the tests in the CI.

> 
> Please find some connection to the real world before sending any new
> version of this (e.g. via test scripts). I think this should not be
> pulled before almost anyone doing kernel dev can comprehend the "gist"
> at least in some reasonable level.

You'll find in this patch series (cover letter, patch description, and
comments) connection to the real world. :)
The next patch series should take into account the current discussions.

> 
> BR, Jarkko

