Return-Path: <linux-api+bounces-5959-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEpsJZE+tGnZjgAAu9opvQ
	(envelope-from <linux-api+bounces-5959-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:42:57 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC50A2874D1
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7EE7300692E
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F93C4576;
	Fri, 13 Mar 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uslgCbXS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5093C6A58;
	Fri, 13 Mar 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420170; cv=none; b=Spq9zIrtY4Dflnwik612AJEVq/ioopRBkfLKNy3b3xXUQwUemhe8xwqE8jr89zOAmfPq179rF+ixDLI5tY40kB6XBis6cs8LCkwiql7SRUzwuEw7bg9MPRxqLRfzKayIpRttX3ughlVNALaXGMIFMFCtopbFpedY55lj0z7ftuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420170; c=relaxed/simple;
	bh=mOMRfWZSfcHpPwf4Ag5513CQUKEpRHtLy20Sld+Kv/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrqbFfFw3u3A/i6J/KDzQTL+1jEKQZlSBI926El1BZxqISM+lLf0eqoF3KU9DhWGUlPqp7aQLZ7es8o/DxPgMFN9N106pficL6Ko+E5bYLZuYNkbi2YAPtt9J8ccW/cTTpnImhUMch6Z8QM0tVTi4Qs/WclpGEhbtKaGfzvPCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uslgCbXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A654C19421;
	Fri, 13 Mar 2026 16:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420169;
	bh=mOMRfWZSfcHpPwf4Ag5513CQUKEpRHtLy20Sld+Kv/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uslgCbXSWlzcoh5Pzs7r+w6oVsO+vyT3U4f/2HUficc91TwkuDFpfVRv0yyT4FCw7
	 Bs4kfp1acZcs8pBHh0zq8RjhBf4eipAl9h0DhruYAGukhmLwPKNuypPqdLbRqS414B
	 8HlmUu7whGV6r4xiGbwG3e7qx24vIArR+qFnHLqZ6kWBcABaK+WFiVoQ7DF5vaHZrK
	 1TUCRhIZplQCv3bh4QxRZarp891Y0+n8d0w2+lZMHQEZONB7vtHTc2pN0S7QEnVMom
	 2I6SEtC4qpXdAb78OSmHe1LQl7lzvzczr9DF6prhZu77Rk7YygPH2mg0hpioQ0K+x6
	 95rys0lRapmGg==
Date: Fri, 13 Mar 2026 12:42:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] kernel/api: add API specification for sys_open
Message-ID: <abQ-iIylzpuqlRv3@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-6-sashal@kernel.org>
 <2026031343-raft-panhandle-0a21@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026031343-raft-panhandle-0a21@gregkh>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5959-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,linuxfoundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC50A2874D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:33:57PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 13, 2026 at 11:09:15AM -0400, Sasha Levin wrote:
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>No changelog?

I'll add something to all patches.

>> + * since-version: 1.0
>
>I think since older versions :)

Right. I guess that in my mind 1.0 was the first official "release". I'll
update it to 0.01.

>Anyway, very nice documentation, will be good to have this as part of
>the kerneldocs no matter what the result of this patch series is.

Thanks!

-- 
Thanks,
Sasha

