Return-Path: <linux-api+bounces-6005-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0xCkm1umlWawIAu9opvQ
	(envelope-from <linux-api+bounces-6005-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:23:05 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F02BCFE1
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0ADB30AA509
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D53D9DBE;
	Wed, 18 Mar 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/2JI14t"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55093D8117;
	Wed, 18 Mar 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843138; cv=none; b=lnfVVIjxnHDf/ypzPC4/xRITU0PEBXTN7kqXLDUEuOiYVxhXkOpsOBsrEJDmxoymIeYoO+f/WiBFE5AhllYoAlllDZIWnPwWLQd44m9Q9tGEFcuknOjv5SE3nFqJLlUzRJOOlDOjGWYf9pI4LYwLk16Vx5wQe38ZJgehFg3ZcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843138; c=relaxed/simple;
	bh=IXLmuwZSj5HSQo0tXWv3jOtalQVrJJQSZpbmeg/KbZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI+YtEnuJi66xY3DrRkHw+4G6t4ajaENdGEXLDu6AXBoOX9JcoXDDKLE/2XA0r2aa3WlKvYYAugO7weIMddwLtbMZ5L5T9HP+ZkoVWaJEcundXFfTVHNFG8R2RGSjcBCIktAazL7dj8LMzaeAoyxMOmDV7Tm4Z86+Yawi2iFPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/2JI14t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93490C19421;
	Wed, 18 Mar 2026 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843137;
	bh=IXLmuwZSj5HSQo0tXWv3jOtalQVrJJQSZpbmeg/KbZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/2JI14td5+LKwp+H9zABf8u7nvEipOZ6K872WIuzTaZpe/ImVkxCNnGwpXKs+NDK
	 BrHtqY92Bw8ZMAoREajpxAdZHfz5lYmo5Lyz3QRwUp0TqjABu4Ns4pJ6KNfCQmDOHI
	 WB7yn4Z1WX42HjH4l8LJeOwRcaHBct2SLFn+MKp/Y3tps5GKuuO6sAdhHDU+ReUi2U
	 RspedWUhZWcmWIVPV3C5NL7L1ESVDg8z48DHtlLcjpPRzzBDJy6teoDaaIgHY/rqoL
	 7Avdi31tl+YqiO8GsORYLlzhFHk6bAVRa04off99x/0A8Fzd8ZgRd56HOXKGEWXZDU
	 MuOystwLEJMMw==
Date: Wed, 18 Mar 2026 10:12:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <abqyv0DiT0LFUU4v@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-6-sashal@kernel.org>
 <2026031343-raft-panhandle-0a21@gregkh>
 <abQ-iIylzpuqlRv3@laps>
 <878qbq9uau.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <878qbq9uau.fsf@trenco.lwn.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6005-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,kernel.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.892];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 737F02BCFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:37:13PM -0600, Jonathan Corbet wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> On Fri, Mar 13, 2026 at 04:33:57PM +0100, Greg Kroah-Hartman wrote:
>>>On Fri, Mar 13, 2026 at 11:09:15AM -0400, Sasha Levin wrote:
>
>>>> + * since-version: 1.0
>>>
>>>I think since older versions :)
>>
>> Right. I guess that in my mind 1.0 was the first official "release". I'll
>> update it to 0.01.
>
>That kind of raises the question of just what since-version means.  The
>version-0.01 (or 1.0) version of open() surely didn't do everything
>described in this specification.  So it's saying that some version of
>the system call has existed since then?

You know, I'm not entierly sure what the definition should be here.

I stole this from man pages where they indicate at which version the API was
introduced in. I'm not sure if it really adds any value.

Any objections to just dropping it?

-- 
Thanks,
Sasha

