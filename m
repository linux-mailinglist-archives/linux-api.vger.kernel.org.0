Return-Path: <linux-api+bounces-6327-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALf8BcSEA2ot6wEAu9opvQ
	(envelope-from <linux-api+bounces-6327-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 21:51:32 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A188528D79
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 21:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E7A3049943
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2026 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C8357CE3;
	Tue, 12 May 2026 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7couW5c"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153025B085;
	Tue, 12 May 2026 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615471; cv=none; b=NwK4gywGp+ELwNbBpayNq50ZjM0tJb3ic386FdeXaA+Ni+WO8DQxu24l/jxcGPcuR3x4HQP0Lh/ijdHFbnFJZthZfhClz5JiI+D0+1NfVSK6AnHSrE0qPhIOrZ+oSjnQrt6XFu8aziNmav0pJ4dF+rhsh8nNxCv0ZUoI6591wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615471; c=relaxed/simple;
	bh=b1KoHPaKFuGQ4klYDDLOw5CHCxr9eqLnjpUbFtjJ5Vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFOcEsXm60V0re/8c25EV3sh+Ly9qkIp+yvSvEuhn7L9qFW52Kvm9aJ/544OWb69oaw5W0Tr9PwJd6NMh+lKVexhhLhsEPW+fN7R3HZ3OsnYox4tAdAjZJv3tv5icEKf2yTmTuLxhwNkpB75Kt0VVtxRfygxL37sAaNqkq0LG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7couW5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD1FC2BCB0;
	Tue, 12 May 2026 19:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615470;
	bh=b1KoHPaKFuGQ4klYDDLOw5CHCxr9eqLnjpUbFtjJ5Vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N7couW5cLLd1JIz5/38P6NjHACO6RntSN6Yq/eApAe8yYJfLFN7EAJ9sTW+v4hBHE
	 E/rAR/fdQeL8twrXSRWW4WYaMTLxKqZTNPTD/13JTJKfxKIWacjN9Eznq55vCeYnF3
	 wM4+9XXvrStxyakPDohej6BnLW84eagxP2aSocyePDPYG3mlRSGKhds1S3Lp6Q0p4O
	 z/pFFoS61KRJ87lXwt/B5tKW5K9WEXsgTubzQ1A8JMs7U5O1zEFBJm2Y6jMy2Ix2e2
	 9q8XifxZYAordJr4Q+nqpi06VXRlCCVHNxHSrVhgGNXeD85JIDQIUGzH3MkLWfRIoH
	 xG2hI9FeqQvkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D563811A59;
	Tue, 12 May 2026 19:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v14 0/8] bpf: Extend BPF syscall with common
 attributes support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177861541680.3056308.7326619347008693525.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:50:16 +0000
References: <20260512153157.28382-1-leon.hwang@linux.dev>
In-Reply-To: <20260512153157.28382-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, brauner@kernel.org, sforshee@kernel.org,
 yuichtsu@amazon.com, aalbersh@redhat.com, willemb@google.com,
 kerneljasonxing@gmail.com, chen.dylane@linux.dev, yatsenko@meta.com,
 memxor@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 rongtao@cestc.cn, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
X-Rspamd-Queue-Id: 7A188528D79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6327-lists,linux-api=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 12 May 2026 23:31:49 +0800 you wrote:
> This patch series builds upon the discussion in
> "[PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure" [1].
> 
> This patch series introduces support for *common attributes* in the BPF
> syscall, providing a unified mechanism for passing shared metadata across
> all BPF commands, initially used by BPF_PROG_LOAD, BPF_BTF_LOAD, and
> BPF_MAP_CREATE.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v14,1/8] bpf: Extend BPF syscall with common attributes support
    https://git.kernel.org/bpf/bpf-next/c/f28771c0691b
  - [bpf-next,v14,2/8] libbpf: Add support for extended BPF syscall
    https://git.kernel.org/bpf/bpf-next/c/b1bff4080942
  - [bpf-next,v14,3/8] bpf: Refactor reporting log_true_size for prog_load
    https://git.kernel.org/bpf/bpf-next/c/503c039ffeca
  - [bpf-next,v14,4/8] bpf: Add syscall common attributes support for prog_load
    https://git.kernel.org/bpf/bpf-next/c/ac89d33fdd81
  - [bpf-next,v14,5/8] bpf: Add syscall common attributes support for btf_load
    https://git.kernel.org/bpf/bpf-next/c/ceeb7eda94a3
  - [bpf-next,v14,6/8] bpf: Add syscall common attributes support for map_create
    https://git.kernel.org/bpf/bpf-next/c/49f9b2b2a18c
  - [bpf-next,v14,7/8] libbpf: Add syscall common attributes support for map_create
    https://git.kernel.org/bpf/bpf-next/c/702259006f93
  - [bpf-next,v14,8/8] selftests/bpf: Add tests to verify map create failure log
    https://git.kernel.org/bpf/bpf-next/c/f675483cac1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



