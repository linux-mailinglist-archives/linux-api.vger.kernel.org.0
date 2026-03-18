Return-Path: <linux-api+bounces-6012-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEXmDrzouml0dAIAu9opvQ
	(envelope-from <linux-api+bounces-6012-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 19:02:36 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CF92C0E3F
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 476703196AE5
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8630FC34;
	Wed, 18 Mar 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="WulDNP+7"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E642291C10;
	Wed, 18 Mar 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852718; cv=none; b=Z1MSE4gUio/AO24MADzrTU25SQhIhVeZuVCD40K/KvzIfjIHl/18MZeDWFoZ6PabEiuw+0LT1IpVhuqkXFZQ6Gx+csSkayDj/7efy7zoJ/xeqNQ1EgVH3Uusi5Dg9FDkdwrwr8w7tCujpT4o2eA13brVhDg5rXhpXk9xC2srZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852718; c=relaxed/simple;
	bh=o/7yE6t93yQtFz6v7eAty53R//5LEtd721EuvOxoFn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ry1YugnDZ6UrEDel3xG0RLCAuWYL4pH4mefB8867JWXOuNGYlkGJoBJ7HbQ+9oiw5EbpLGbNyUNDMzfuzQzDuwz6IV6HCHyuOsrK0v+fY6z7T0W8cIidAUbcNCAlProPu/eTfqECS7Q1InbpvJzviPZxuognERlMRR1VEPOh5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=WulDNP+7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0DEB40423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773852717; bh=nwEcRE80LRGRnH9IJ42jxIknbbtHfjezvT1c6qQwbv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WulDNP+7m6R8KkZAmeQSGPLvxaBvyXQI3v8TmWnQJHpjpLqPlKPJVWSwB4DatvWg3
	 rt+SLAibuW96kRdSaOHpEuKw/vI3du5FlbI77xppMGnbxiRi5f1PTKH6zQAZNTz3fD
	 7lYEJmmvcfYwypJHzACPy3BbF+zm7L4mq7PgPbdVIdw+OxSHRrZpGnIKX76mhOz3jP
	 8KZxYjeaT/mVq+xis0VkYp/IJtfBs8I8+rlsyPViutIJ2bf2grknK6n2LdqEeMKDAk
	 +MrzzQC6TEeUpSgHQgo7VHnbZHoMbbeb5KepqqlXsE9iRWTiY7dIX/SkuRUNIaEb/A
	 jo1pLvWiAW/RQ==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E0DEB40423;
	Wed, 18 Mar 2026 16:51:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, Thomas
 Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov
 <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis
 <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>,
 David Laight <david.laight.linux@gmail.com>, Askar Safin
 <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo
 Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
In-Reply-To: <abq3f5vdcwRXGJGX@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-2-sashal@kernel.org>
 <87h5qe9wig.fsf@trenco.lwn.net> <abq3f5vdcwRXGJGX@laps>
Date: Wed, 18 Mar 2026 10:51:56 -0600
Message-ID: <87jyv95bdf.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6012-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lwn.net:dkim,trenco.lwn.net:mid]
X-Rspamd-Queue-Id: 34CF92C0E3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Mar 17, 2026 at 11:49:27AM -0600, Jonathan Corbet wrote:
>>So the reason for two completely separate mechanisms is not entirely
>>clear to me.  The kerneldoc variant is essentially documentation, while
>>the macro stuff is to be built into the executable?  What if you want
>>both?
>>
>>It would be nice to only have one way if at all possible; I'm sure that
>>crossed your mind at some point :)  If there have to be two, having both
>>examples describe the same function would make the parallels more clear.
>
> Woops, I forgot to finish writing my reply to this :)
>
> Under the hood, kerneldoc specs are translated into those macros so they could
> be part of the build process and embedded into the resulting binary (both for
> documentation as well as the runtime validation).
>
> I don't think anyone would use the macro format directly, but as it's there
> anyway I figured I'd offer it as an option. Would it make sense to just hide it
> behind the scenes?

If there are two ways of doing it, people will use both ways.  My
kneejerk reaction would be to hide the macros as an implementation
detail, but perhaps that's just me.

Thanks,

jon

