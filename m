Return-Path: <linux-api+bounces-6706-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IMnCA1aXPWqm4ggAu9opvQ
	(envelope-from <linux-api+bounces-6706-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:02:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A856C8A6B
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:02:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=zytor.com header.s=2026052701 header.b=rPouVeku;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6706-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6706-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zytor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4553830387A9
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA17325706;
	Thu, 25 Jun 2026 21:02:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2E21CA03;
	Thu, 25 Jun 2026 21:02:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421329; cv=none; b=kjO8YxLgkt4zblG0crNQuFJUpKpYLHSS36Xci5Z/JjuppDYAePK4d7Lh7jmyw3rIyq6BcfHLuw0VEOoU3I7pIdfmc3FBfJBsm+9WXdpjYn0rRtjm5gGYWFA7c+QsIkwYG0A5Snh8hl5CAcN04dLE6NVm3qeeq66vOZ1Iu0kd3b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421329; c=relaxed/simple;
	bh=KKpCuldyUjZ9ra7Ij03/KnQY+uzxGKwUzKdHAMFYuWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcBhT496cuB+/QLDOwNNf0JlS88YZuLa46a90LtEbUWby2171Z0XojBwmvGDMIAOydgzURuSsMApYDiDRDUgDaxw48tK1IhykKCNLHOn9dj+McT4Ch2xeqYNC7Yn9qHYmfxGViMUqSaEHSky/CVMIlBRW8ay/g8wKBd2uFgcpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=rPouVeku; arc=none smtp.client-ip=198.137.202.136
Received: from [IPV6:2601:646:8081:7da1:4336:f681:2dbf:7257] ([IPv6:2601:646:8081:7da1:4336:f681:2dbf:7257])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65PL16H23185257
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 25 Jun 2026 14:01:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65PL16H23185257
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026052701; t=1782421274;
	bh=J+Ja7l7yri21/GM1tHKaRy8u0aE9q/VYwuBcGfp/kwU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rPouVekuk+j67QyNq3jmzxfkNZtEh/hyIOgOQqSDxhaQQYCku7NnonoInzXL5sUe7
	 Z+Bvd/4DiKXu0L9MjBCb41qwRbZusc0vN5xca+jpbseiY9KdG5IyOyAqMePIWe8AL8
	 WKD01g45b75x+wVUym4j9Q/14VocaP2XGRnhie2fFR6XxYvmNOkNgQr6Gt9G7TyJq1
	 2KTHHvepvc/xrn4+fh+TYwDaCe5DyxYfB1eiO4P0dwra+kEfJtuzbRJeUFR0or+JF6
	 4xmS4P24dnE0A8U+Kws2ZNJwGe3LvXXgzpdS3dDf6rQQvH57RBKj2tV+wAaWYqA3DX
	 qyXawPFTzwIEg==
Message-ID: <29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
Date: Thu, 25 Jun 2026 14:00:59 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Null Namespaces
To: Al Viro <viro@zeniv.linux.org.uk>, John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>,
        Christian Brauner <brauner@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
        Sergei Zimmerman <sergei@zimmerman.foo>,
        Farid Zakaria <farid.m.zakaria@gmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260624231219.GL2636677@ZenIV>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260624231219.GL2636677@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026052701];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6706-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hpa@zytor.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,zytor.com:dkim,zytor.com:mid,zytor.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35A856C8A6B

On 2026-06-24 16:12, Al Viro wrote:
> On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> 
>> #### Null mount namespace
>>
>> - requires:
>>
>>   - null root file system: absolute paths don't work.
>>
>>   - null current working directory: relative paths with traditional,
>>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.
>>
>> - All operations relating to the "ambient" mount tree don't work.
>>
>> - `*at` operations with a file descriptor do work.
> 
> Huh?  The last bit looks contradicts the previous one - if you have
> an opened directory in a mount from some namespace, those `*at` operations
> with that descriptor *will* be seeing the mount tree of that namespace,
> whatever the hell is "ambient" supposed to mean.  Either that, or you
> will be exposing whatever's overmounted in that mount, which is a huge
> can of worms.

It seems to me that this is really no different *in practice* to having an
empty mount namespace, no? You might still be able to stat("/") and get a
d--------- result, but how does that actually affect anything?

The big thing with a lot of this is that introducing a null case can really
complicate things all over the place, and since this is very likely to be only
a niche use case, it kind of screams to me like it has the potential to become
an attack surface like any other rarely used code in the kernel...

	-hpa


