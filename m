Return-Path: <linux-api+bounces-5930-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FAbMlEqsWkBrgIAu9opvQ
	(envelope-from <linux-api+bounces-5930-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:39:45 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5425F809
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 09:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB50303A3D8
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124233AEF25;
	Wed, 11 Mar 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlk4Q8yu"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8F3B9D94
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773218091; cv=pass; b=sD8/745ovCpY3PyYxyTE3Twmmw7hGRblvDoz1YmMnkn25Ja3UK+SvmWLxmaqI/5U/9Ro3j5Y3dfhmKCwuGtjm9Ly8W+iUGqKb9pgqZndnk9gQXVh8OMek1omcJq3ysMCtZ8knj2p4mKnaJLF/+cVpJIxmkS4I3JW1tidLVCttZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773218091; c=relaxed/simple;
	bh=SsapxUY06a7cs9bBuRB3R8cKxgdqx7oMrI3eEaj8qe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDPhjM3gHpwKeoOJeaADR2pROo2VvE1D69b771mGLOt7qdIKU/FrEDGH6I6vexA/4FoVZ4JdLdXMAWMBxr8awm+4cx9wOTc3udQ82Seo/whnr3FH9zZREONJVGmhfpYaOoTt4ey5ghx0JWIRYKGz1qKzWWFI8Iyz2Yw0o2GTVCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlk4Q8yu; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd7ecedf2cso344485785a.3
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 01:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773218084; cv=none;
        d=google.com; s=arc-20240605;
        b=dBzzRlLQXvIAMKpE+4v/mA+19uSAZ9ZBkKsqXzRpnXLwRqMu2Y33liXl62U8CCoXLP
         oh0Tia0Y/A7rZqlFsurJpawdGvE5luVQl/sKETO1sk5WDMwCK0C44ezJmpIn12TlXEML
         7Q5cmj9eqCr4KeO67bvaVChSNarVdaMjj3q9Oux5R4iAP9nUjJBoS5qFpf60cB3p5/Lt
         e99+0gxnMeWqKndVsRUMjB9lFGFZpMZcjunxznkHANtlrkrAnbPmEOhJlyFC7y3Yyyld
         Gt+1FzDbB90gav/mfgdZfFBN6Q/RDeU9ech8o8sarzFzkg/mhPZEITlrC2vqjA3vkupU
         VGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=infw2GOKBa/xQ0FaqhlrOevyT/EEGe52s1hqFD6TVIs=;
        fh=yATsLVDXfWTyT+rqzhiON1rRqsUoijLL6u4re8w6NV8=;
        b=IGR7iB7/Oh57fIWvU/ChGzYdtGpHDW3FYea3UcxAG46UFjyIi8ZBVkmbBVxv85EzIm
         kKRejZ0rPXOt1IqKZ1rfFM4SAhr6dU+dH1TbrTsryIfH1M3qC9TFmnIIw8jcb/v3mrhw
         /3c/SNlwSEDBBU1/hL+P1p7P3v8GY8/AchMBB5WS0f42zjDaHYaUrSELDrKbZPyhjrgB
         EOq/4JtEzK7JyJqgKszX+Yacux97pO5zXRaJvCTxg8PViNZFlDvYEqPSdrQdvy5mUwFP
         gM3UA4fWz4habLOocy5Rw+MRUmsgCtKnm8zRadk4/cVUJVE+J6Wdjdv0CyEricxDmW5T
         fYUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773218084; x=1773822884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=infw2GOKBa/xQ0FaqhlrOevyT/EEGe52s1hqFD6TVIs=;
        b=hlk4Q8yuViuaZ1defw2+7C1/3pvIVJguTIjEDJ+mqoYMaxn6LVrLcHXfndrlvY7qzu
         rhrSJ8jHMNez9R37G8qhA868kTE64M7NLAFtnUWyJxkpUg+7VuKzbrlm8TbozbcriFdm
         aTOoQJMBsDG6mZsab2j5c3+Up/oNto26+SNMFS+nh7j97f0rFlqEMLHwhrUzhPw2ouOx
         k/H08RstCdFj5vaN3KiYkGmrMydgtowhs1KeWl/YrfsHewWHCtbc89umaMT92PSVKvSg
         qcZBsClFH8t0EfRf4DIFzLXGU9mGpp+bIHiX7Yui7/SFApAe3RCMSdi2mkx28cO4GbMQ
         FLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773218084; x=1773822884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=infw2GOKBa/xQ0FaqhlrOevyT/EEGe52s1hqFD6TVIs=;
        b=CiLe+GQJSmowwZ+hb3t9f94rtCxyu0QTvqyM4+F+4/tozsOokQGw4zC5O5v5icRDuD
         B5TAwMPlZe1bdP6bcVSLN79IVfL8tC6V9gh5xdxrv9EHE5uOdlfUmpHzYkOsWYQNI18Z
         4YsQwFJXUL51TFxlpdyms8zA8cbLCtet3rUGSpoMxVsgCd+JsK9Sy5HWaDE5Tmx/IO1j
         C6/B64GVd46XzdtjjR+zybWs8oNoVF6qUxXtA0sS5KksGPIwFqkShHCWySQbcOQ6Oq6c
         lQOEQ/jkjCNDwC0u+YTjK3YjtY/VbKaoEb3cTpQ85s+G+6DPuPSlrO0JDv18nKUiR88Q
         X6zA==
X-Forwarded-Encrypted: i=1; AJvYcCX0Q/5AAhMbjnHE5U9sshtiWx76f71XPks+RhSQqP4leJGieor0JTysQ56ANhsd3+70EIJozwIiLwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXjHhgtJoParjmh4VMymSIoHJj1PRhU4A36+Jznc8BjRY9+BhM
	bruSNrsOQOsokaZXFTiIUeW7CTCxC+jpcf3PeN+v0BlLQNDyrut3P6SSThbm1MfHmP/Jbf6li1B
	OX2WnehlMftx9mSFyDDhu+E5o5hkdFkp8DF/ecrI9
X-Gm-Gg: ATEYQzyBRpJ/Xd0VttMa+6eUW9/ojJ9gflGcP/XrvdmbylBOM29js1ioxSjJhiQFlwm
	yT0PxTXAlVp/7CsMzxfpCNt2t9mltN7/J+W/5Io50ooq2r6AskmEhondnQY2RBcfOiY7AQO1qGG
	Iy/MdZFVU4kae/l0ih1RkdDl4+5ZLaF9BWUl2AARP+PnBueGCJLkBwrSsB6dJQzzDglQ/cIY7xo
	bmjguP/sWcmtC5z24l6kp+my0JADSB8vWHfs/affYcqn9jcKfpEXwaOK1hGU1WXAVKiYk/MHUDZ
	cmMT/dxr
X-Received: by 2002:ac8:5f89:0:b0:509:20de:4ada with SMTP id
 d75a77b69052e-5093a18950amr18737181cf.48.1773218083994; Wed, 11 Mar 2026
 01:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075600.948413-1-atwellwea@gmail.com>
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 09:34:32 +0100
X-Gm-Features: AaiRm52wCKdcSWz9oNAzUWL_GQOag0jSamOEmON1h9c132p0nbosojJsMVy1eJA
Message-ID: <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
To: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	kuniyu@google.com, horms@kernel.org, geliang@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com, 
	linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4AF5425F809
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5930-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,lists.linux.dev,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 8:56=E2=80=AFAM Wesley Atwell <atwellwea@gmail.com>=
 wrote:
>
> This series keeps sender-visible TCP receive-window accounting tied to th=
e
> scaling basis that was in force when the window was advertised.
>
> Problem
> -------
>
> `tp->rcv_wnd` is an advertised promise to the sender, but later
> receive-memory admission and clamping could reconstruct that promise
> through the mutable live `scaling_ratio`. After ratio drift, the stack
> could retain or advertise a receive window that no longer matched the
> local hard rmem budget.
>
> Fix
> ---
>
> - store the advertise-time scaling basis alongside `tp->rcv_wnd`
> - refresh that pair at the TCP and MPTCP receive-window write sites
> - consume the snapshot in receive-memory admission, clamping, and the
>   scaled-window quantization path
> - preserve the snapshot across `TCP_REPAIR_WINDOW` restore when userspace
>   provides it, and fall back safely when legacy userspace cannot
> - expose the accounting in tracepoints and cover the ABI/runtime contract
>   in selftests
>

Your series will heavily conflict with Simon's one

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1063486&state=
=3D%2A&archive=3Dboth

I suggest you rebase/retest/resend after we merge it.

> Series layout
> -------------
>
> 1. track the receive-window snapshot state and helpers
> 2. refresh the snapshot when TCP advertises or initializes windows
> 3. use the snapshot in receive-memory admission and clamping
> 4. extend `TCP_REPAIR_WINDOW` for exact restore plus legacy compatibility
> 5. refresh the TCP shadow window snapshot in MPTCP
> 6. expose rmem/backlog state in `rcvbuf_grow` tracepoints
> 7. cover legacy and extended repair-window layouts in selftests
>
> Testing
> -------
>
> - `git diff --check origin/main..HEAD`
> - `scripts/checkpatch.pl --strict --show-types` on patches 1-7
> - `make -j8 headers`
> - `make -j8 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minis=
ocks.o net/ipv4/tcp.o`
> - `make -j8 C=3D1 CF=3D'-D__CHECK_ENDIAN__' W=3D1 net/ipv4/tcp_input.o ne=
t/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
> - `make SPHINXDIRS=3D'networking/net_cachelines' htmldocs`
> - `make -j8 vmlinux bzImage modules`
> - `make -C tools/testing/selftests/net/tcp_ao -j8`
> - `make -C tools/testing/selftests/net/mptcp -j8`
> - `packetdrill --dry_run` for `tcp_rcv_toobig.pkt` and
>   `tcp_rcv_toobig_default.pkt`
> - `virtme-run` guest pass for both packetdrill tests
> - feature-enabled guest pass for `restore_ipv4`, `self-connect_ipv4`, and
>   `mptcp_sockopt.sh`
>
> Thanks,
> Wesley
>
> ---
> base-commit: 908c344d5cfa0ee6efb3226d22ea661e078ebfa0
> --
> 2.43.0
>

