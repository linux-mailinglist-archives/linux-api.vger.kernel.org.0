Return-Path: <linux-api+bounces-6006-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKlyOpSzumlWawIAu9opvQ
	(envelope-from <linux-api+bounces-6006-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:15:48 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C92BCD70
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C38A3024A1E
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3023DA5CD;
	Wed, 18 Mar 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzdkQVwb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583523D9DDE;
	Wed, 18 Mar 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843254; cv=none; b=WwhB3ZJuumMzyfQglF1UOr1UkQaBQScY1DaW34pax17cyUAHU82RjRiFEZ0UEo92tzxSHtEZMvOGb5kdgVPSE7HkJc1Y+Vvh4AXrnJVJasFM6p/Vr7IAvPWUMfo6abj+SVG3otAUBQG//h8J2ioG8biFPlMLVrwPK9AQnw5J+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843254; c=relaxed/simple;
	bh=HPOd8av0zkvPB5Jq+2D8kTe1uRlAAJQLKHhW1me+kbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQF9VAqs4fjArXftBzY+gvBxLjajfU5ato015n/YEwyGRuBxNQHnZWLl1cQuYOwRmYLDmkwfNuIbTGazXsuP22/P1KL6SukHNDYsVzunpspKW/XKaCM9iva0QarfYaSryc9Q1dra2k4Q0nz2HeQdmyF/TZmn4wAYUOy93oWpa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzdkQVwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A4AC19421;
	Wed, 18 Mar 2026 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843254;
	bh=HPOd8av0zkvPB5Jq+2D8kTe1uRlAAJQLKHhW1me+kbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzdkQVwb82dEzBbXvF70Z1p9D3TneAvmkgYsv9NacC23G0MVhbN9Rx4jWwAjcE5Oh
	 57DAm4TOA6HEUMNqjgyv6l5dHRi+tCUlSm4xGnfP2AVOcjje97jxMW7DeCOA4EbU5t
	 k61o5rlp6u/6m/EwndDElJndj887uX3ri786McXpoN9ITA+Za5BQiZ+iCyzO3Pf743
	 AAMKfn7HrJiYmWXFF8tH6b43Giq4oxvLCd44QsRPacsKIxFddyCKTtEbsfjnNWT2iD
	 6On1YlVkQMCGJlS3bpB04OlZRh9tUnqxymZfzlF6ccEcl9dblkGxOb8G4krSF/+KZ3
	 9OnFWRUhNV0nQ==
Date: Wed, 18 Mar 2026 10:14:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <abqzNIeZCM0ODiFm@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260314111822.63a2ba4a@kernel.org>
 <abZTg9ZwnE5J4qXa@laps>
 <20260318072410.72618011@foz.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260318072410.72618011@foz.lan>
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
	TAGGED_FROM(0.00)[bounces-6006-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D5C92BCD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 07:24:10AM +0100, Mauro Carvalho Chehab wrote:
>On Sun, 15 Mar 2026 02:36:51 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> On Sat, Mar 14, 2026 at 11:18:22AM -0700, Jakub Kicinski wrote:
>> >On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
>> >> This enables static analysis tools to verify userspace API usage at compile
>> >> time, test generation based on formal specifications, consistent error handling
>> >> validation, automated documentation generation, and formal verification of
>> >> kernel interfaces.
>> >
>> >Could you give some examples? We have machine readable descriptions for
>> >Netlink interfaces, we approached syzbot folks and they did not really
>> >seem to care for those.
>>
>> Once the API is in a machine-readable format, we can write formatters to
>> output whatever downstream tools need.
>
>Kernel-doc already does that. The way it works is that it handles
>kernel-doc markups on two steps:

Cool, I'll take a look. We could throw away the source parser in the kapi tool
and just use the kerneldoc parse.

-- 
Thanks,
Sasha

