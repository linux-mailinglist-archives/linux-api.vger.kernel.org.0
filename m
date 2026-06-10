Return-Path: <linux-api+bounces-6594-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hK/VHNZYKWqhVQMAu9opvQ
	(envelope-from <linux-api+bounces-6594-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 14:30:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A753C66949C
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 14:30:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.beauty header.s=zmail header.b=WvDDwVgj;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6594-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6594-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.beauty;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25AAF3018C16
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BC406823;
	Wed, 10 Jun 2026 12:29:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2E406800;
	Wed, 10 Jun 2026 12:29:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781094590; cv=pass; b=TnfvLDr95hNUheTnKAunI7xXjAtWl9vRRvDY6uHQ7eNMH8yCjdCMXQ3nSRIDG76JDbRUv4cQOOIQZ2l16uh11WWMDXdvJ1gddbudISGKRl1BcMTae3Kr3W0i1vtyz13EqzIcJ5t5KmzjdIH8PowdC7EARbSIjRThSw/twb23MRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781094590; c=relaxed/simple;
	bh=Ehyp2sjyZl9fsCoc42SNrwhrfpyVX2OogBueMKKla8k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZfALBHkRxy0vPQW8rZOwHm+vB3RKH9qoEh1mU3+x63geoX1QhMKFq/tGsbG2c2qCTu2TrtaizwBWgdV0YN+QaIcIhtlhl9+/vNhIr3oBsGWv664gjNRwCv2e3J5Ltkk+5w7Vn1TiGI6GrIOCmmleUoFLR1m8o83mSv3mFPh5e6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=WvDDwVgj; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal: i=1; a=rsa-sha256; t=1781094549; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P8D++KH7LHOQpE3Rrq+mnUydsarX4SA8jf37vzhCBVtdpXd9oICu2vM2tNQE2bw3EFi7weXZFFlzkHl3SxvVMsMUCMuPU8dM3Y+1GvEQzIF+Rpw+70J/Vn9h5lvB+1/bAaGU2fvr/YCOpyAXkTMf8ymyMRLKwp9+J+IJkNeTga8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781094549; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ckf24HwJNr0/jCTjEgcbMFrOZMOX2rhuYx11RBKLbRI=; 
	b=mUTmYgpyHmOoGuHezBtMDvJHAJNG71qY/+PD9+moxQK1Jkh8pok05MkSrIHHKZON0v60ZFQRagSjcoBE9A3ANnVxEQN0NUXx3D2VhglOkHIiMqyDzIJcAQk3agMZP+EERK4I+OV2mvfOdE1pnChPg/ID1zDYRGJXStzi/5plQyw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781094549;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ckf24HwJNr0/jCTjEgcbMFrOZMOX2rhuYx11RBKLbRI=;
	b=WvDDwVgjxHIb6Ld4g/STPkj/qNyJrcX72eFf7bqJitIWy/EzMXAo4o6Q5lwnf870
	homOUv6wByNuqLwm/c7J6HHcMwiq8lbk1Td4lWIWiSg0M2rKPVn77MjTWE8BnhZv2Zv
	9YTeG3B1BxTxwESjMHgSAHbmGhCWNG4mipLqXTSM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781094546927254.30322356312638; Wed, 10 Jun 2026 05:29:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 20:29:06 +0800
From: Li Chen <me@linux.beauty>
To: "John Ericson" <mail@johnericson.me>
Cc: "Andy Lutomirski" <luto@kernel.org>,
	"Christian Brauner" <brauner@kernel.org>,
	"Kees Cook" <kees@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"linux-mm" <linux-mm@kvack.org>,
	"linux-arch" <linux-arch@vger.kernel.org>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>,
	"x86" <x86@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
	"Thomas Gleixner" <tglx@kernel.org>,
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Message-ID: <19eb181fdd4.6d028f442844776.3737831021032223216@linux.beauty>
In-Reply-To: <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
References: <20260528095235.2491226-1-me@linux.beauty>
 <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner>
 <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
 <19eacd64508.26b92c022125848.262962729296162879@linux.beauty> <4e049396-377d-48a7-a34c-91318413a876@app.fastmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:luto@kernel.org,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6594-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A753C66949C

Hi John,

 ---- On Wed, 10 Jun 2026 01:27:47 +0800  John Ericson <mail@johnericson.me=
> wrote ---=20
 >=20
 >=20
 > On Tue, Jun 9, 2026, at 10:43 AM, Li Chen wrote:
 > > Hi Andy,
 > >
 > > ---- On Tue, 09 Jun 2026 08:01:57 +0800  Andy Lutomirski <luto@kernel.=
org> wrote ---
 > > > [...]
 > > >
 > > > After contemplating this for a bit... why pidfd?  Doesn't a pidfd
 > > > refer to an actual process that is, or at least was, running?  This
 > > > new thing is a process that we are contemplating spawning.  I can
 > > > imagine that basically all pidfd APIs would be a bit confused by the
 > > > nonexistence of the process in question.
 > > >
 > >
 > > Yes, I think that is a real concern.
 > >
 > > In my current local WIP I tried to keep that distinction explicit.
 > > pidfd_spawn_open() returns a pidfs-backed builder fd, not a normal pid=
fd
 > > referring to a process. The builder fd is allocated as an anonymous pi=
dfs
 > > file with builder-specific file operations:
 > >
 > >     file =3D pidfs_alloc_anon_file("[pidfd_spawn]",
 > >                                  &pidfd_spawn_builder_fops, builder,
 > >                                  O_RDWR);
 > >
 >=20
 > What does your builder fd point to, explicitly? For example in my other =
reply I
 > talked about how it was "real" process state. In my FreeBSD patch, for e=
xample,
 > I found there was already a status for a process "in exec", and I figure=
d that
 > was clean to reuse for one of these "embryonic" processes that also hadn=
't
 > started running. I would reckon that Linux probably has some similar not=
ions.
 >=20
 > > and the normal pidfd helpers still reject it because it does not use t=
he
 > > ordinary pidfd file operations:
 > >
 > >     struct pid *pidfd_pid(const struct file *file)
 > >     {
 > >         if (file->f_op !=3D &pidfs_file_operations)
 > >             return ERR_PTR(-EBADF);
 > >         return file_inode(file)->i_private;
 > >     }
 > >
 > > So the current split is:
 > >
 > >     builder_fd =3D pidfd_spawn_open(...);       /* builder object */
 > >     pidfd_config(builder_fd, ...);
 > >     child_pidfd =3D pidfd_spawn_run(builder_fd, ...); /* real pidfd */
 > >
 > > Only the last fd is a normal pidfd for an actual child process. The bu=
ilder
 > > fd is only accepted by the builder operations.
 > >
 > > This avoids having to define what waitid(P_PIDFD), pidfd_send_signal()=
,
 > > pidfd_getfd(), poll(), etc. mean before the process exists.
 >=20
 > I wouldn't be so sure this is necessary/good. For example, I think it co=
uld
 > make sense to wait on a process that has yet to be started; one just wai=
ts for
 > both the process to start and the process to exit. Obviously a blocking =
syscall
 > in the thread that is spawning the process is not useful, but the asynch=
ronous
 > poll variation seems fine.
 >=20
 > As long as there is real process state here, it shouldn't be too hard to
 > implement.
 >=20
 > > The downside is that it adds a separate open-style entry point and is =
less
 > > uniform than the pidfd_open(0, PIDFD_EMPTY) spelling Christian sketche=
d.
 >=20
 > I do think there is no point having two file descriptors. The file descr=
iptor
 > that previously referred to the builder/embryonic process then can refer=
 to the
 > real process, right?
 >=20
 > > If people think there is a better way to represent the pre-spawn build=
er
 > > state, or if the preference is to integrate it directly into pidfd_ope=
n()
 > > with an explicit empty/future-pidfd state, I would be happy to discuss=
 that.
 >=20
 > Hope the above answers your question? I suppose my ideas lean more on th=
e
 > "future" than "empty" side --- there is indeed a thread in the thread gr=
oup,
 > with real VM/namespace/file descriptor etc. state. Moreover, state gets
 > initialized before the process is started, so the actual start is a pret=
ty
 > lightweight step of just letting the scheduler know the now-ready proces=
s can
 > be scheduled. The only thing that distinguishes the embryonic process fr=
om a
 > real one is simply that it isn't running --- i.e. isn't (yet) available =
to be
 > scheduled --- so the pidfds holders are free to poke at its state.
 >=20
 > Cheers,
 >=20
 > John
 >=20

Thanks, this helped a lot. I looked at FreeBSD/OpenBSD/XNU after your
note. FreeBSD has P_INEXEC, OpenBSD has PS_INEXEC, and XNU seems even
closer with P_LINTRANSIT, described as "process in exec or in creation".
Linux does not seem to have a single equivalent today: current->in_execve
is only an LSM hint, while the real synchronization is spread across
exec_update_lock, cred_guard_mutex, and the exec path.

I am switching my local WIP from the two-fd builder model to one fd,
closer to Christian's sketch:

fd =3D pidfd_open(0, PIDFD_EMPTY);
pidfd_config(fd, ...);
pidfd_spawn_run(fd, ...);

In my current local version, I still use copy_process(), so the fd points
at a real task_struct/pid that is not woken until run. Following
Christian's point that existing APIs can handle this not-yet-running case
with ESRCH, I currently make ordinary pidfd operations that need a real
started process return -ESRCH before start.

I am not sure yet whether Linux should grow a general exec/creation
transition state like that, or whether a narrower future-process
lifecycle is enough for this API. I will think more about that when
working on the pristine process version.

Regards,
Li=E2=80=8B


