Return-Path: <linux-api+bounces-5958-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNRxMwI7tGk4jQAAu9opvQ
	(envelope-from <linux-api+bounces-5958-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:27:46 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E67286FFA
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 17:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F039301062D
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48883612EE;
	Fri, 13 Mar 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ys7i1O"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC613019A6;
	Fri, 13 Mar 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419254; cv=none; b=lgC/OH9YrVxY6l4kEHIlsjYOdMT/kKp5buRr6/RuVOxqQSGL97oNXFuKcYGm54NQm3Z8RFwdqutUQOSztmMnXhHHURGjO21qVmkm4jRfq0yG/wnvM+roJBeYN/W32Pi6by4a0udtS/bXIMtArVuxIiQ6XkLMEFDzLRki1AsV75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419254; c=relaxed/simple;
	bh=/eJtS8h0mKw/fLWieWSxlYbg5ksWap1zDbR7F4gZ0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXg9wbU8h2lAhbV2qBl7rpN8CD/6gFh+gIS8t4hWRXVh2K2C5yvG8I99rzHmqmaJ9ndK90EL6Qn/HZiCqRSrINDHJDAYuaKoB26CEeiC38erp9DbHbFUsnRGJmhQUBlWCiSE4FX8AWvcuhTz5OHFG03kuWVvoz1x76bnDBsLfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ys7i1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B561C19421;
	Fri, 13 Mar 2026 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419254;
	bh=/eJtS8h0mKw/fLWieWSxlYbg5ksWap1zDbR7F4gZ0Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5ys7i1O4Oyyqudvfshayx5x83ZBrEEd0hPy5o7hcH9EDWSkBdxYYZhK0r1GGyM5G
	 syCsC3eq1DUtsRKhNj21oAjko603bAQ8oYUQSwVNYXJYnpkqJrZrzL+Qr9e/x3BaDJ
	 M37e6xzk+OxV1qR3jc4v11SJY98DLwi/oLO/z/dp5RHapEBh2nFHW1mxc2t1ayskjP
	 OgjJTag8HwIxlnqHx55zKZEE15NKqEvjn2la7wrAn7lMgyKNFTLEAaJPUj811LesBL
	 GRHk15xq6KF2kJ/9MYge7WEDYF85dN+2wkTaIg/SiwbDVxI2Mij/HaLc6uTCfqkcto
	 kSe137WPVc22w==
Date: Fri, 13 Mar 2026 12:27:32 -0400
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
Subject: Re: [PATCH 3/9] kernel/api: add debugfs interface for kernel API
 specifications
Message-ID: <abQ69FmtBqXX6Irz@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-4-sashal@kernel.org>
 <2026031301-duplicate-finalist-b7a5@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026031301-duplicate-finalist-b7a5@gregkh>
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
	TAGGED_FROM(0.00)[bounces-5958-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E67286FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:32:23PM +0100, Greg Kroah-Hartman wrote:
>On Fri, Mar 13, 2026 at 11:09:13AM -0400, Sasha Levin wrote:
>> Add a debugfs interface to expose kernel API specifications at runtime.
>> This allows tools and users to query the complete API specifications
>> through the debugfs filesystem.
>>
>> The interface provides:
>> - /sys/kernel/debug/kapi/list - lists all available API specifications
>> - /sys/kernel/debug/kapi/specs/<name> - detailed info for each API
>>
>> Each specification file includes:
>> - Function name, version, and descriptions
>> - Execution context requirements and flags
>> - Parameter details with types, flags, and constraints
>> - Return value specifications and success conditions
>> - Error codes with descriptions and conditions
>> - Locking requirements and constraints
>> - Signal handling specifications
>> - Examples, notes, and deprecation status
>>
>> This enables runtime introspection of kernel APIs for documentation
>> tools, static analyzers, and debugging purposes.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/dev-tools/kernel-api-spec.rst |  88 ++--
>
>You are removing stuff from the file you created earlier in this patch
>series, is that ok?

Sorry, just a rebasing artifact from shuffling patches around. I'll fix it.

>> --- /dev/null
>> +++ b/kernel/api/kapi_debugfs.c
>> @@ -0,0 +1,503 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Kernel API specification debugfs interface
>> + *
>> + * This provides a debugfs interface to expose kernel API specifications
>> + * at runtime, allowing tools and users to query the complete API specs.
>> + */
>
>No copyright line?  :)

I'll add one.

>And this is, a totally and crazy interface with debugfs, I love it!

Thanks :)

>Two minor minor nits:
>
>> +static int __init kapi_debugfs_init(void)
>> +{
>> +	struct kernel_api_spec *spec;
>> +	struct dentry *spec_dir;
>> +
>> +	/* Create main directory */
>> +	kapi_debugfs_root = debugfs_create_dir("kapi", NULL);
>> +
>> +	/* Create list file */
>> +	debugfs_create_file("list", 0444, kapi_debugfs_root, NULL, &kapi_list_fops);
>> +
>> +	/* Create specs subdirectory */
>> +	spec_dir = debugfs_create_dir("specs", kapi_debugfs_root);
>> +
>> +	/* Create a file for each API spec */
>> +	for (spec = __start_kapi_specs; spec < __stop_kapi_specs; spec++) {
>> +		debugfs_create_file(spec->name, 0444, spec_dir, spec, &kapi_spec_fops);
>> +	}
>
>No need for { }

ack

>> +
>> +	pr_info("Kernel API debugfs interface initialized\n");
>
>When code is working properly, it should be quiet, no need for this as
>initializing this can not fail.

ack

-- 
Thanks,
Sasha

