Return-Path: <linux-api+bounces-6308-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ky3ETgHAmpEnQEAu9opvQ
	(envelope-from <linux-api+bounces-6308-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:43:36 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36DC512857
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D452326B13D
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF29542669C;
	Mon, 11 May 2026 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuboAVld"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1063CF660;
	Mon, 11 May 2026 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516371; cv=none; b=arX1E8eVtBkmUfyF+qzFPcpYXWLWvc8vncKD57htxddiN1VXkppr21dgbk+8KQQkC9Lgj05REZ3ZLoBfWnKjuiK17PqZRN90ryngGg1FdlbAKzYRpIv4frY6B5Vvdya8c26QQ/WzOq1TTry/fZnmVT4zrYD2TxnYFt5YSSpbGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516371; c=relaxed/simple;
	bh=eze9RQV3hbB21kKo3b7RsDRVzX5i/gy14ILzEtPDtJk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jQK8CYd/HNYnnaFvXRmYND0kCAlJNx6aQjkuumUr6JAWcyeY/xIegrC3pJfNSTs/Z5YFJ/3gMQJ5YGFbnrwoARBKHXWTDrnHrXIhcYfI1KX3j3N3i6lQJF+zkyNgyq1XEZXewzp9awfGOtW9sMzS2aPlb1w+lbImibtDOo06GGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuboAVld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1590C2BCB0;
	Mon, 11 May 2026 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516371;
	bh=eze9RQV3hbB21kKo3b7RsDRVzX5i/gy14ILzEtPDtJk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fuboAVldJnc8wqVWB5q7NV2IUJOvgtwJSxN1hZq2lDxAqbQa/Np/AoR63755Ulxiw
	 7RAgGzQrn8MlIniPYcDoqzBJX+fMoRsTEKv51xSAaY4H962pydfWvI9YiF15czMZ9O
	 MghVJ1N9gT9rkuXxL5f93K/J/9n3G7r5gJA/V4xZvro3iKL21Cjsvk/csgnmGBQyNH
	 OcNGCOp3KSHQVgJPZTP827zYj93lVmSc7xglfCdpHXAnvaJ5VOjb1XuWCZqVgPnbQn
	 IRntFctvwRBvubyUSwveR8DDseEAqDL5MG59oXRIAjveFfjXkRKSN0BW4CC71f7rMw
	 ZbN7QPc37HsGg==
Content-Type: multipart/mixed; boundary="===============0378492382572556629=="
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fad54bcc2f9363f61cda44680e7189ad7a510d81dc52f444a4c30a3fcd37df1d@mail.kernel.org>
In-Reply-To: <20260511152817.89191-7-leon.hwang@linux.dev>
References: <20260511152817.89191-7-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes support for map_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,leon.hwang@linux.dev,willemb@google.com,kerneljasonxing@gmail.com,chen.dylane@linux.dev,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 16:19:28 +0000 (UTC)
X-Rspamd-Queue-Id: B36DC512857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-api@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6308-lists,linux-api=lfdr.de,bpf-ci];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============0378492382572556629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8433430dedb7..c15a4c26a43b 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index fd12ad5a0338..62fe6ed18374 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2fa05ba8f161..54b43e16848a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -1611,6 +1632,31 @@ static int map_create(union bpf_attr *attr, bpfptr_t uattr)
>  	return err;
>  }
>
> +static int map_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_attr *attr_common,
> +		      bpfptr_t uattr_common, u32 size_common)
> +{
> +	struct bpf_verifier_log *log;
> +	struct bpf_log_attr attr_log;
> +	int err, ret;
> +
> +	log = bpf_log_attr_create_vlog(&attr_log, attr_common, uattr_common, size_common);
> +	if (IS_ERR(log))
> +		return PTR_ERR(log);
> +
> +	err = __map_create(attr, uattr, log);
> +
> +	ret = bpf_log_attr_finalize(&attr_log, log);
> +	if (ret) {
> +		if (err >= 0)
> +			close_fd(err);
> +		err = ret;

When bpf_log_attr_finalize() returns an error (say -ENOSPC for log buffer
truncation or -EFAULT for copy_to_user failure) after __map_create() already
returned a negative error (for example -EINVAL from CHECK_ATTR or -EPERM from
security checks), does it make sense to overwrite the original map creation
error with the log finalization error?

The result is that userspace receives -ENOSPC or -EFAULT instead of the
actual reason the map creation failed. A user with an undersized log buffer
might retry with a larger buffer expecting success, when the real issue is
that the map creation itself was rejected for a different reason.

Looking at bpf_check() in kernel/bpf/verifier.c (around the verifier log
finalization), it uses similar logic with 'err = ret;' reassignment. However,
that doesn't appear to have the preserve-original-error comment that would
clarify the intended behavior for this scenario.

> +	}
> +
> +free:

Does anything use this free: label? The only exit path before it is the early
return for IS_ERR(log), which correctly returns directly since log is an error
pointer and doesn't need cleanup. There doesn't seem to be any 'goto free;'
statement in the function.

With -Wunused-label enabled by default in the kernel build (part of -Wall),
this will generate a compiler warning. When building with -Werror (common in
CI configurations and allmodconfig builds), this would break the build.

> +	kfree(log);
> +	return err;
> +}
> +
>  void bpf_map_inc(struct bpf_map *map)
>  {
>  	atomic64_inc(&map->refcnt);

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25680759838
--===============0378492382572556629==--

