Return-Path: <linux-api+bounces-6309-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLv+CRUDAmrknAEAu9opvQ
	(envelope-from <linux-api+bounces-6309-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:25:57 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C408C512138
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84980328625B
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8C426ECF;
	Mon, 11 May 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY8h9US4"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0E82F8E81;
	Mon, 11 May 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516376; cv=none; b=lfN44dWhauj/xFydF4Ojy7z9SUrkedj2YJcMQe4dXbPsT/W3qDyG6HGKNjo40Vnmqwo8TDZ/a52WpzeugXjxG83xODaE8RO9OIH+nXuMwwGYGvrnCSXGY1sK9xtq7ZhHD2c5L1eoe5F+9cbA+zy8WsRIjawFHTywzeVdsIcZVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516376; c=relaxed/simple;
	bh=yXbDOKa2927Kfjg50SfPrrhYmV94+W8G5c6jvkIvWAE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=c/RqZO0+4i3wRIA7jgDij2eXzpPkAm6X/U4oex7Wa5GviL0x9eOXBN/AR5WlmeaTt9otNP30IlNL5RSVrMqqvd6LKOpJB3ZML0yWDJL1+YMOwWPpCw+CmHsrKahpVO9aGkYRYCiPhMru8o8qRw2Jq1wTHYxvcZkKzFwf/Jelxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY8h9US4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4BEC2BCB0;
	Mon, 11 May 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516376;
	bh=yXbDOKa2927Kfjg50SfPrrhYmV94+W8G5c6jvkIvWAE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VY8h9US4MbmUYBa7eIcdEMpxauFNHN5FS4u0+yKBKrOJkpm0Jvk+1ibcqdJeDTeZj
	 lC6oaImUlbw7qYEIuQXQOWpWwNYriZvD748zjsaI33CgVf30SFRRF/twQ8auICaPog
	 NqKuxgEwizoxxaBQGSAi2H8n4Y502AZzbDqdqg/+XP4zAGGau9ByhfD0tuiLWvnamH
	 uCdw3YfllNGX8D6shrvpWk7yrbvgvdBx0Be3hnq+Crv37A+8DhHO6xMDXxeLaC9mO1
	 DjFhLIYbYWgxVexQrRJ5e0V+nU9Gpz4NaCHpc7kn39b9c4fTDbZMwujxRtBvZOTpeK
	 2psO7jbPr/uuQ==
Content-Type: multipart/mixed; boundary="===============2939612789620637439=="
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <810f123d14450d09d147d90dea25ddf5091e636542fcc5729d0594bfbd622757@mail.kernel.org>
In-Reply-To: <20260511152817.89191-2-leon.hwang@linux.dev>
References: <20260511152817.89191-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v13 1/8] bpf: Extend BPF syscall with common attributes support
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,leon.hwang@linux.dev,willemb@google.com,kerneljasonxing@gmail.com,chen.dylane@linux.dev,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 16:19:33 +0000 (UTC)
X-Rspamd-Queue-Id: C408C512138
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
	TAGGED_FROM(0.00)[bounces-6309-lists,linux-api=lfdr.de,bpf-ci];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--===============2939612789620637439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f5639d5ac331..50055ab73649 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -936,7 +936,8 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
>  asmlinkage long sys_getrandom(char __user *buf, size_t count,
>  			      unsigned int flags);
>  asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
> -asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size);
> +asmlinkage long sys_bpf(int cmd, union bpf_attr __user *attr, unsigned int size,
> +			struct bpf_common_attr __user *attr_common, unsigned int size_common);
>  asmlinkage long sys_execveat(int dfd, const char __user *filename,
>  			const char __user *const __user *argv,
>  			const char __user *const __user *envp, int flags);

[ ... ]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 677be9a47347..16ff0968fc21 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -994,6 +994,7 @@ enum bpf_cmd {
>  	BPF_PROG_STREAM_READ_BY_FD,
>  	BPF_PROG_ASSOC_STRUCT_OPS,
>  	__MAX_BPF_CMD,
> +	BPF_COMMON_ATTRS = 1 << 16, /* Indicate carrying syscall common attrs. */
>  };

[ ... ]

> @@ -1500,6 +1501,13 @@ struct bpf_stack_build_id {
>  	};
>  };
>
> +struct bpf_common_attr {
> +	__u64 log_buf;
> +	__u32 log_size;
> +	__u32 log_level;
> +	__u32 log_true_size;
> +};
> +

Should log_buf use __aligned_u64 instead of plain __u64?

Looking at other pointer-bearing fields in the BPF UAPI, they consistently
use __aligned_u64. For example, the existing BPF_PROG_LOAD log_buf in union
bpf_attr is declared as:

    __aligned_u64 log_buf;  /* user supplied buffer */

The __aligned_u64 attribute forces 8-byte alignment on all architectures,
including 32-bit systems where native unsigned long long alignment is only
4 bytes. Without this attribute, struct bpf_common_attr will have different
layouts between 32-bit and 64-bit ABIs:

- 32-bit: 20 bytes, 4-byte aligned
- 64-bit: 24 bytes (4 bytes of tail padding), 8-byte aligned

While the current __sys_bpf() implementation with bpf_check_uarg_tail_zero()
and min_t() capped copying handles this gracefully, deviating from the
established BPF UAPI convention could create problems for future extensions.
If another __u64 field is added later, the inter-field offsets would diverge
between ABIs.

Would it be better to use __aligned_u64 log_buf to match union bpf_attr and
preserve identical struct layouts across 32/64-bit ABIs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25680759838
--===============2939612789620637439==--

