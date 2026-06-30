Return-Path: <linux-api+bounces-6748-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QR8aLMsFRGq7nQoAu9opvQ
	(envelope-from <linux-api+bounces-6748-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 20:07:07 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0226E7191
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 20:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026062701 header.b="ibz/fgpG";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6748-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6748-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C8F304B889
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575973E0C4A;
	Tue, 30 Jun 2026 18:06:36 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947923E0240;
	Tue, 30 Jun 2026 18:06:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842796; cv=none; b=Da+EBN6Nn7wgzlSg01C0mnb5q4LSbDGzbELL/1jg0fmI43eLsKfwFZQllchB7bRRhZfQW1SfEsnycqhH6MZjNbkiZDJsLr0UFese4Tivs4S6n2aEOGITKzzJ2PE1kM0i3LbQKEOjG7VlQUHdZAdy0C2I+oOMZJEYNHt+2Cjq8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842796; c=relaxed/simple;
	bh=2TsGzHVgKfbxyM5f1ogG9RK6lsEUJ7HmCpy7NFi1wWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mw6btnV+W08U9DlZcZNKOtMkZMz7hw2aJboyTznKHQX/kRPzcI0hnSK2Rbbr8N3Hw+/OT/+TB368DHD2wrzVafkcoIpFp2EKTo198wjoZCvX3aGtK2GA1szjvDcNobYgjf9xatCQOfjReXa9Nj883I0ACZYEdO+usUwH+GpvCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ibz/fgpG; arc=none smtp.client-ip=198.137.202.136
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65UI5chi3385725
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jun 2026 11:05:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65UI5chi3385725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782842741;
	bh=2TsGzHVgKfbxyM5f1ogG9RK6lsEUJ7HmCpy7NFi1wWM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ibz/fgpGzNXunBpkhhPXuudWse0DPvg3ogv1rzayppNCQENd+OcFBaV3+5PXu/1KM
	 i5hhCPwep9+wGTOTLp13NvnbK4/h8UPy27/j6mF9porP197gybbXVo6gNLllhOCxwR
	 I5JjhHfN+41FBZFhCc5BpJPvGPd0dEL8XlLQPfSYfW0xslaHsgcAfNFSs2pqWOJJip
	 3uQwns4qo98hJmZbOQRCrUUWDv+cLVNjGkoJscaCMMpAK7TbizQEDLe9vOSr/hdvKr
	 4O4u7z56TV3f43IIcU+f8tCa7RasfMB8LQIX3Ibx9tvQpYn5olCT3zJn0BMmBX9zz0
	 avRR6L71oeokA==
Date: Tue, 30 Jun 2026 11:05:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: John Ericson <mail@johnericson.me>, Christian Brauner <brauner@kernel.org>
CC: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
        Sergei Zimmerman <sergei@zimmerman.foo>,
        Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
User-Agent: K-9 Mail for Android
In-Reply-To: <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com> <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com> <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner> <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
Message-ID: <B921C9EF-9BAB-4EBC-B7A2-1095FAB6B36B@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026062701];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6748-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:brauner@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,zytor.com:dkim,zytor.com:mid,zytor.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E0226E7191

On June 30, 2026 10:20:05 AM PDT, John Ericson <mail@johnericson=2Eme> wrot=
e:
>I'll throw in the towel after this email, I promise :)
>
>On Tue, Jun 30, 2026, at 3:14 AM, Christian Brauner wrote:
>> I think Al is about to have a stroke reading this=2E=2E=2E and I might =
too=2E
>
>Hahaha=2E Alas, C does have a longstanding beef with discriminated unions
>--- I can't do anything about that! (Well, other than wait 15 years for
>this stuff to eventually be rewritten in Rust, that is ;)=2E)
>
>> I agree with the sentiment
>
>Thanks, I appreciate it :)=2E
>
>> You know what the easy solution is: don't allow a struct path to be
>> empty=2E=2E=2E
>
>Just so we're clear, my quibble here is purely behavioral: the nullfs
>directory can be opened, right? And that open directory can also be
>getdents64ed (yielding no entries, since it is empty), right? If I am
>wrong about these things then sure, no objections from me --- let's ship
>nullfs FDs right away!
>
>My reasoning for being a bit of a weenie on that behavior is just that I
>think "fail fast" is good=2E A lot of userspace programs crawl the file
>space pretty willy-nilly (e=2Eg=2E they are doing some caching thing, or
>they are looking for something, etc=2E)=2E I suspect the nullfs approach =
is
>going to result in more "red herring" error messages and google searches
>about "why can't I write to the working directory, not even as root"
>etc=2E I just think "no directory" vs "immutable empty directory" sends a
>clearer message to userspace, and will align mental models more rapidly=
=2E
>
>Put another way, if there were no implementation downsides to either
>approach, I assume everyone else would also slightly prefer "no
>directory" over "immutable empty directory"=2E
>
>From that premise, I am further presuming that any non-empty `struct
>path` to a directory that doesn't exist would be a real VFS crime, and
>so making `optional_path` one way or another is the proper way to
>implement this behavior=2E
>
>If I am wrong about either step of my reasoning --- that nullfs like
>every sort of FS ought to be openable/readdirable with sufficient perms
>at the root, that a valid `struct path` to a "non-object" is bad design
>--- do say so, and I'll drop the `optional_path` stuff completely=2E
>
>> I disagree with the details of this
>
>You mean the unergonomics of making a valid `optional_path`, right?
>
>> and touching the whole kernel for this=2E
>
>I want to make sure this is a difference in opinion and not a difference
>in the view of the facts=2E
>
>The linchpin of my prior email was that very little of the kernel cares
>about these fields in `struct fs_struct`, or even cares about `struct
>fs_struct` at all, so this is *not* a "whole kernel" change=2E Yes, thank=
s
>to `current`, a bunch of code *could* look at this stuff if it wants to=
=2E
>But it should *not* want to, regardless of what we do=2E
>
>If there were a way to make parts of `struct task_struct` opaque
>(without including another header) to enforce this design principle, I
>would definitely go contribute that=2E (I remember the desire for
>something like this coming up with the "fast headers" patches, but there
>wasn't a good implementation strategy in C, alas=2E)
>
>Likewise, for the tiny few usages outside of `fs/namei=2Ec` that I found,
>I would be happy to more creatively look at that code to see if I can
>indeed avoid `struct fs_struct` altogether=2E
>
>Cheers,
>
>John
>
>P=2ES=2E The "regardless of what we do" part was key to my earlier code
>review argument that gave you "mixture of amusement and slight anger":
>of course I don't expect other maintainers to keep abreast of subtle
>null pointer invariants, but the simple rule that nothing but
>`fs/namei=2Ec` really ought to be consuming these `struct fs_struct`
>fields is, I believe, all three of: good, already true, and intuitive=2E

15 years?=20

Don't make me laugh=2E=2E=2E

