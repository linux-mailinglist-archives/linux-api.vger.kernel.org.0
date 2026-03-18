Return-Path: <linux-api+bounces-6009-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGr4BK+3umlWawIAu9opvQ
	(envelope-from <linux-api+bounces-6009-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:33:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD87B2BD331
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4805730234CD
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF53DB627;
	Wed, 18 Mar 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMiZeZar"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987933D9024;
	Wed, 18 Mar 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844353; cv=none; b=NF20/xqmCg6UQ/ZDTjeUOnCQX6Sno2FPywL8vBogzAxfPVbcsaWHRx3x65E2cTTnboV6jwCVuN1NbuPpG6g54bSlryqsD5xPoG895Or5HJvmxt8R5AT1CLKeJybL41XLv7dT8WJNpeH/VeMN0X1uiV/U8TqL9eEaf+J+gdZQoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844353; c=relaxed/simple;
	bh=BkmNwvxpHD2rLSHreIl/KbDAd8IvuTpcKZIoErK/PhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDWr0bJo4Ai5aJMv0mvOa1xg8EIjeBDXSfMX44nUhnG11sBPyhfWfWkR9QrD1om0+fDPq7Tn0wM5NO5eDfrfAhDUHa1bWek4qgV7G4T32084hYo0WNtNffOsb4R/pBDK/cKWFldW355Co4IuhOqDBR3/KL4gYyeXsbwFV2yvy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMiZeZar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D4BC19421;
	Wed, 18 Mar 2026 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844353;
	bh=BkmNwvxpHD2rLSHreIl/KbDAd8IvuTpcKZIoErK/PhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMiZeZarKo0I6In8lAdDvOsPtB+Akkqq5eFK8sm/YRM5xM4gSk3GswcKWLx9V8CPt
	 +6YYl1xS3tNFIQTKhM40jfz1qPoTtm1elg0NV868yjkd5chJjTqeJgEOV6/CjRxzkT
	 mQDFtdNKBQ/xnnBOebXJ71uzotCfxEva6Zj23n1drQV+9WtCXRpVecdCosRr9wxlY6
	 vtHhNHxZOYqX6DbExKyJvA7EW6fnoLWGHN6VIBgcwGz0PUL81aWr7tYmmCfeBlaDZE
	 JbKmbSr+/Nh08b6WAlxfXt1VYRX2lavS093MPyeFA2L5/Ib4WDc+a58iauuYvq8QNp
	 QgG84UCJntIbA==
Date: Wed, 18 Mar 2026 10:32:31 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <abq3f5vdcwRXGJGX@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-2-sashal@kernel.org>
 <87h5qe9wig.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87h5qe9wig.fsf@trenco.lwn.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6009-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD87B2BD331
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:49:27AM -0600, Jonathan Corbet wrote:
>So the reason for two completely separate mechanisms is not entirely
>clear to me.  The kerneldoc variant is essentially documentation, while
>the macro stuff is to be built into the executable?  What if you want
>both?
>
>It would be nice to only have one way if at all possible; I'm sure that
>crossed your mind at some point :)  If there have to be two, having both
>examples describe the same function would make the parallels more clear.

Woops, I forgot to finish writing my reply to this :)

Under the hood, kerneldoc specs are translated into those macros so they could
be part of the build process and embedded into the resulting binary (both for
documentation as well as the runtime validation).

I don't think anyone would use the macro format directly, but as it's there
anyway I figured I'd offer it as an option. Would it make sense to just hide it
behind the scenes?

-- 
Thanks,
Sasha

