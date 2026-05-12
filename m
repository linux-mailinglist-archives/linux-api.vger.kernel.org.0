Return-Path: <linux-api+bounces-6325-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE8gGglUA2pD4wEAu9opvQ
	(envelope-from <linux-api+bounces-6325-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 18:23:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1264C5249A8
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 18:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34D1F300644E
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0C63CC7FD;
	Tue, 12 May 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/jLp9ep"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6223B1022;
	Tue, 12 May 2026 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602996; cv=none; b=k957SbPd/qDw+8nfNuJeu5u6F1ec+y1XN7PlnxG6OmASQp7k1ppMuE8iAupwECk6Etm6l/WnofAxuEMNXPRe66lm4FBROGNvTolelYMRRjNBRqseo78lNWzoUUZg5/eVMtO0El7hwwKgw+cfa2qWOREu48XU4E6BoWxt8b2Uoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602996; c=relaxed/simple;
	bh=vYDNHoFu5KGezYeSr31ivJsn2rFbeSkn+mNV5uEwneM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GJ6dI5MgJDjPJJs+ZPaXcaHU0U5QZOr9GBWekTdY2w7r29xhOjTSeu9GRwyRybhLRZNgrE1GAoNBRK/uxqWzq2sGKApcDlaXiXxZH0EMN6s7rV+8QsxUQQCQsKHJdoABoOpuyrRHg8zbLnZfp2wBbibhwR4dpJGuNH9pbxyc10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/jLp9ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E1C2BCB0;
	Tue, 12 May 2026 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778602996;
	bh=vYDNHoFu5KGezYeSr31ivJsn2rFbeSkn+mNV5uEwneM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=g/jLp9eplTyhbaoHBeRl7S+zwt3ZPUlKoEAL5lZOzrck8PGPQNtOaMZ+5q0R7VzK9
	 1pVOob1Pfh83TUo9mo0B7nfcFDwvBuMgNaPA+UIqYioE0uxPplso+ou3p9NDh5QKUH
	 OW2P/zy+/ZMNGY0qTu3eVBRQfME1N4C2OFUyzEADhVrURvUYsGFyYX+8bEjqDvhdEk
	 ON7ZSgS7SnBoRqYljSyJ2IwoP32Zk4kp7sJzAlImLrW2Af4IJwIHP64sihN8tzlR/K
	 IHvaG+W3Ip5dlGsz4ft+46/PAWd7CRYqlwLg+k+IL/3SnGrIGn/BFB3ysICGxGLLs4
	 pnTfGLqKA07Ug==
Content-Type: multipart/mixed; boundary="===============6389190805276887042=="
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44819125e8a416353eb3e314e7804d2c762ea87331f98f1396eaa8b86421d950@mail.kernel.org>
In-Reply-To: <20260512153157.28382-3-leon.hwang@linux.dev>
References: <20260512153157.28382-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v14 2/8] libbpf: Add support for extended BPF syscall
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,leon.hwang@linux.dev,willemb@google.com,kerneljasonxing@gmail.com,chen.dylane@linux.dev,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 12 May 2026 16:23:15 +0000 (UTC)
X-Rspamd-Queue-Id: 1264C5249A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,vger.kernel.org,fb.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-api@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6325-lists,linux-api=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============6389190805276887042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 5846de364209..9d8740761b7a 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c

[ ... ]

> +int probe_sys_bpf_ext(void)
> +{
> +	const size_t attr_sz = offsetofend(union bpf_attr, prog_token_fd);
> +	union bpf_attr attr;
> +	int fd;
> +
> +	memset(&attr, 0, attr_sz);
> +	fd = syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr, attr_sz, NULL,
> +		     sizeof(struct bpf_common_attr));
> +	if (fd >= 0) {
> +		close(fd);
> +		return -EINVAL;
                        ^^^^^^

Should probe_sys_bpf_ext() return 1 instead of -EINVAL when fd >= 0?

The probe function detects kernel support for extended BPF syscall
attributes by calling the BPF syscall with the BPF_COMMON_ATTRS flag
and a NULL pointer for common attributes.

The expected outcomes are:
- New kernel with support: errno=EFAULT (can't copy from NULL) -> return 1
- Old kernel without support: errno!=EFAULT (invalid command) -> return 0

If the syscall succeeds (fd >= 0), that definitively proves the kernel
accepts the extended syscall format and supports BPF_COMMON_ATTRS. The
function should return 1 (supported) rather than -EINVAL (error).

Returning -EINVAL causes feat_supported() in features.c to print a
warning "Detection of kernel BPF syscall common attributes support
support failed: Invalid argument" and mark the feature as MISSING,
incorrectly reporting that the kernel doesn't support the feature when
the successful syscall proves it does.

> +	}
> +	return errno == EFAULT ? 1 : 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25745661172
--===============6389190805276887042==--

