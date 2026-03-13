Return-Path: <linux-api+bounces-5960-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IDeM1Y/tGlljgAAu9opvQ
	(envelope-from <linux-api+bounces-5960-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:46:14 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB7B2875C2
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53464305A2EC
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B43C945E;
	Fri, 13 Mar 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEQay8sw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6B3C3BE8;
	Fri, 13 Mar 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420363; cv=none; b=mxXwIjXLhYIxDEJmpdkQ1ftc/TtPPZ+9ArXF9w0ow06eduOHOFvO9nWl5ql5LIH0a4726lmAXRZGSUydOaDgjp4/Xuqh9gnIXCovLdeOx6HPVpIGb4Cp3cHfxO6D5VDzdxuzHhjmp4CAtido4/mmQb2vkEXI0D17Yry5c0fwzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420363; c=relaxed/simple;
	bh=NcjJzioaIshYM6Iq0uBNPZILW5sdu988IaZAOFh28iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7PGaESjE8xWW89PUTOodOhwqylNRMF84cJ+oh2G9Mk3dCXbZySZySKcrGRQRiSz66yYe5dHoeNmFtIwLeiGRPKtLc0UdeMsoflymsTaBSTUzwaIZJ3oi4WrWo6emIuSVIlMyM61nN2ZAzj3ZGyNheWuhzIH5XrXcb9Zxo/9BJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEQay8sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87053C19421;
	Fri, 13 Mar 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420362;
	bh=NcjJzioaIshYM6Iq0uBNPZILW5sdu988IaZAOFh28iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEQay8swJ7Z5zFwGRN1gDWzlEZAMVfi6oqqFkvbpVsde4d5ZWSE97+wQqLxsr2AWF
	 C8j3JjZrpcQjAbe2BAZZXIA647lzEKdpVw5aaD+qKoPv0I5/4zetMhLHIbWAnS65nA
	 /1xU7HQVDktn9eMblP0MMO/njUc+qQgBT/PP1Hf9lHIGitrmLP00CFO7Vye8v7ybCJ
	 iNpPYUH+CLw5YCKqG6gU4yuJaput0Q5wu0pCho2QAhNxf8bmwZhP8Mn7ls1Pq8rJ1k
	 KO57/D+Y2hktvZJxmDW1C0qup6321fWIMVxTl76kxitNXVtfqHADB4/lY0smz2tJIH
	 ZIcVSESFeZENA==
Date: Fri, 13 Mar 2026 12:46:01 -0400
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
Subject: Re: [PATCH 6/9] kernel/api: add API specification for sys_close
Message-ID: <abQ_SfbhNfVtYVAW@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-7-sashal@kernel.org>
 <2026031348-deceiving-calculate-0017@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026031348-deceiving-calculate-0017@gregkh>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5960-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EB7B2875C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:49:28PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 13, 2026 at 11:09:16AM -0400, Sasha Levin wrote:
>> + *   Calling close() on a file descriptor while another thread is using it
>> + *   (e.g., in a blocking read() or write()) has implementation-defined
>> + *   behavior. On Linux, the blocked operation continues on the underlying
>> + *   file and may complete even after close() returns.
>
>I'm guessing this came from the man pages?  This is Linux, so we are the
>"implementation" here :)

Right :)

I was just trying to make it a comparison to posix. I'll clarify the docs here.

-- 
Thanks,
Sasha

