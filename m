Return-Path: <linux-api+bounces-6587-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JrYBH6AqKGqh/QIAu9opvQ
	(envelope-from <linux-api+bounces-6587-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 17:00:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C2661736
	for <lists+linux-api@lfdr.de>; Tue, 09 Jun 2026 17:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.beauty header.s=zmail header.b=COdwqkDQ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6587-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6587-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.beauty;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66F7030E628B
	for <lists+linux-api@lfdr.de>; Tue,  9 Jun 2026 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133A392838;
	Tue,  9 Jun 2026 14:43:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42C352C5B;
	Tue,  9 Jun 2026 14:43:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016232; cv=pass; b=XrlGZIXcQV2EGYqEHCYvPlc6oNkWcZ8YiHwnsY6j19pXQzIdg97xa2z6F0dLn10fBAmG6PD9tyS5hl6dnBnIDsZC8DHqv/FSnSIYLipTi8PICNJsQxXBYqeRIkBuRUaPprQEUkAP57ObV2DjY2RaRWAw79Hiv5zdvTGP123ki08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016232; c=relaxed/simple;
	bh=hba8JdKa5DwwyWp0VLcyVqa2151ObpLXyNCan9gFlNs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=R5u8/04IL0X0f5c5QC3XQ2G6ElsBRhgPJxFcAEnJ+gYcPF8LyvL4M/1afjhtcfKPnJp1JRKfQA4wwbqJhfjo4zspoR0XESdIGOS6dLPa+BtU9iEd1LflgunVGVcnkO+RrH3ueU8SkZBaQV0/YWmS1ds/7liRNId57e22mZxxjmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=COdwqkDQ; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal: i=1; a=rsa-sha256; t=1781016191; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h7rLtiBgT6JIZSxmJMtvUqc4vDZXEE84xSFHH7+I7DRRoiIxpI6USJd4jeM5QKxTHLBOjRdGlGPZK491r6Ic0mZHo4E6Os5MnWiN1hQAtcqCaRDitY6VvI2f6oz5eb3b9mj4UTqInmHmmH9FyLo9Z/0p24DR0VZIseC0o1dhDWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781016191; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/y9sk2WKJk6IVRAkewpieDuGt24dURWTghxoT+OO5zI=; 
	b=f9q23nRD9SwH6P0dfQ+zaosNvHpR6OplQgfllXtgS+3kEfwrreImsF/Jw5oxfWk7c+v3pkV1oH1syqog/nU1i9ccZ4I1GbIytyRi6YvbmuDAhDo245bgvuYxw4L4FU3++fOLhMhm6/JQ6zyOrPZnYLAzpv71AKwoFhzJKFwluyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781016191;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/y9sk2WKJk6IVRAkewpieDuGt24dURWTghxoT+OO5zI=;
	b=COdwqkDQJ9R0ZBvzBwIwlx+nRdcQO9W3BEy4BNPz+VcJ0wKYsAMd0YbHmrS6azhT
	338RbHqaewKGsSI9be4yoWBCQGRKqjBZG5nbubYRN/04VYI2Y18hEQ5IZt8uHveiPhe
	CGUwP+qJQjwM8IFoZr8xMCL7e4gyrv2AhDkkmgj0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1781016184094100.75145563479225; Tue, 9 Jun 2026 07:43:04 -0700 (PDT)
Date: Tue, 09 Jun 2026 22:43:04 +0800
From: Li Chen <me@linux.beauty>
To: "Andy Lutomirski" <luto@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
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
Message-ID: <19eacd64508.26b92c022125848.262962729296162879@linux.beauty>
In-Reply-To: <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
References: <20260528095235.2491226-1-me@linux.beauty> <20260528-madig-fachrichtung-fehlinformation-61117ba640da@brauner> <CALCETrWJQpLR4n1cpichBk8=uExSKLWTMGU3BufGdk_WE_p5UA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:brauner@kernel.org,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6587-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.beauty:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-api@vger.kernel.org:server fail];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.beauty:dkim,linux.beauty:mid,linux.beauty:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 506C2661736

Hi Andy,

 ---- On Tue, 09 Jun 2026 08:01:57 +0800  Andy Lutomirski <luto@kernel.org>=
 wrote ---=20
 > On Thu, May 28, 2026 at 4:05=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
 > >
 > > On Thu, May 28, 2026 at 05:52:21PM +0800, Li Chen wrote:
 > > > Hi,
 > > >
 > > > This is an early RFC for an idea that is probably still rough in bot=
h the
 > > > UAPI and implementation details. Sorry for the rough edges; I am sen=
ding
 > > > it now to check whether this direction is worth pursuing and to get
 > > > feedback on the kernel/userspace boundary.
 > >
 > > The idea of having a builder api for exec isn't all that crazy. But it
 > > should simply be built on top of pidfds and thus pidfs itself instead.
 > > It has all the basic infrastructure in place already. Any implementati=
on
 > > should also allow userspace to implement posix_spawn() on top of it.
 > >
 > > fd =3D pidfd_open(0, PIDFD_EMPTY /* or better name */)
 > >
 > > pidfd_config(fd, ...) // modeled similar to fsconfig()
 > >
 >=20
 > After contemplating this for a bit... why pidfd?  Doesn't a pidfd
 > refer to an actual process that is, or at least was, running?  This
 > new thing is a process that we are contemplating spawning.  I can
 > imagine that basically all pidfd APIs would be a bit confused by the
 > nonexistence of the process in question.
 >=20

Yes, I think that is a real concern.                                       =
                                                                           =
                                            =20
                                                                           =
     =20
In my current local WIP I tried to keep that distinction explicit.         =
                           =20
pidfd_spawn_open() returns a pidfs-backed builder fd, not a normal pidfd
referring to a process. The builder fd is allocated as an anonymous pidfs  =
                                                                           =
                                                          =20
file with builder-specific file operations:      =20
                                                                           =
                           =20
    file =3D pidfs_alloc_anon_file("[pidfd_spawn]",                        =
                             =20
                                 &pidfd_spawn_builder_fops, builder,     =
=20
                                 O_RDWR);                                  =
                           =20
                                                 =20
and the normal pidfd helpers still reject it because it does not use the
ordinary pidfd file operations:                                            =
                           =20
                                                                           =
                           =20
    struct pid *pidfd_pid(const struct file *file)
    {
        if (file->f_op !=3D &pidfs_file_operations)                        =
                             =20
            return ERR_PTR(-EBADF);              =20
        return file_inode(file)->i_private;                                =
                                                                           =
                                                          =20
    }                                                                      =
                                                                           =
                                                          =20
                                                                           =
                                                                           =
                                                          =20
So the current split is:                                                   =
                           =20
                                                                           =
                           =20
    builder_fd =3D pidfd_spawn_open(...);       /* builder object */
    pidfd_config(builder_fd, ...);    =20
    child_pidfd =3D pidfd_spawn_run(builder_fd, ...); /* real pidfd */
                                                                           =
                           =20
Only the last fd is a normal pidfd for an actual child process. The
builder fd is only accepted by the builder operations.                     =
                                                                           =
                                                          =20
                                                                           =
                           =20
This avoids having to define what waitid(P_PIDFD), pidfd_send_signal(),
pidfd_getfd(), poll(), etc. mean before the process exists. The downside   =
                                                                           =
                                                          =20
is that it adds a separate open-style entry point and is less uniform than =
                                                                           =
                                                          =20
the pidfd_open(0, PIDFD_EMPTY) spelling Christian sketched.                =
                                                                           =
                                                          =20
                                                                           =
                                                                           =
                                                          =20
If people think there is a better way to represent the pre-spawn builder
state, or if the preference is to integrate it directly into pidfd_open()
with an explicit empty/future-pidfd state, I would be happy to discuss
that.

Regards,
Li=E2=80=8B


