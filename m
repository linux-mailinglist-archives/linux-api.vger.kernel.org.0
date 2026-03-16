Return-Path: <linux-api+bounces-5991-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPG+HWvot2mzWwEAu9opvQ
	(envelope-from <linux-api+bounces-5991-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:24:27 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D052989FB
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87DFE300D752
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3A37CD3D;
	Mon, 16 Mar 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRW2ab8n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV6fEPkw"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580C374169
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660262; cv=none; b=Li68r/kG3ENFlzGrOJOtUQI2Ap1n9dmzTt622fkREupqDnkT503FjYbHs/qHXlLPmvMLFaynvmoDlP6IiS6T1my4bbkYYKAQ3vEQqGnfgHbm1f9at9S1iyV5MlK5wI5xqURsqhKbWtM297zADRHFZZMbscfm9ehs/Y4oJg/RCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660262; c=relaxed/simple;
	bh=vExqsQuY0TOh0C4OqHS5ONqjXZPb4O5dkQOinRtjo/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhIx0XvziZh2qdqndBqC9B8pLgM0uLFZaKbMR/3nIio7hKwTe7YW3JpAKtJT4nfm5/QSUFCWDll1qZRvaqA+6AzGMaTX0TebdNBceR82yeqZ7hLa+t26TQssTpHS86RHpbKPAAvEilKIJIJBIcbxEfG0iBDgRo4RxKfLNIiwiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRW2ab8n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NV6fEPkw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
	b=eRW2ab8nqzwIRaDVDKvqHC1jsQd+SPvi7oxRCPuMvgTpBuqPN75PtUPnjXe2icPYg9Myd4
	0rwVd4VJsfEfceKAxQLLHNPcFtDjTCalcUNs5ZSW2NYYXL7O2IFAPiRNRD4Z0ApKQ3fwkC
	By12vexFATLDwiLRDudhJaZ6IZfxmII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-qumSLr8rM7O6dfr9ARdMKg-1; Mon, 16 Mar 2026 07:24:17 -0400
X-MC-Unique: qumSLr8rM7O6dfr9ARdMKg-1
X-Mimecast-MFC-AGG-ID: qumSLr8rM7O6dfr9ARdMKg_1773660256
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852ccff333so51200385e9.2
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 04:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773660256; x=1774265056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
        b=NV6fEPkwo3NU6CHi+YqL3sv30eFK9RhGWJQR0Knl42QG5QcFR8RBiOI+JigYlrQ+ft
         LGQ8FC4dvwlQ3gOowpzISZ1VOIpl7/aLKeHBalDrxcaglCK55flHNEs0qPgzy661nEHQ
         z35/UnsD686/RIgK7SWhdl/mXAmJVaWLEV5LEDIot/ba+1/LUZUKjIGl6L+UjpRKWnup
         h+QRARlNlUHN0TOsmfY/Qsndq9UJT3hYuCevWZVnPTlpJWvgBzmptRdqo4KZJcNFxA7n
         fGXpt2MMVTI0W7xknSJXubk/Xxi824XhoEAacu613aezcKyhyoTGMiO0QpYEP7Pdl/0K
         ud+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660256; x=1774265056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9hWHpx6fXvQ6tiAS+Vx6gKKziz7E3xCqMnpnyHx+ks=;
        b=ki99uNRZe6BpFPMCM1su0dkbJKSnkD2idxd3mTHKo4+cIeahDhW2Q+WutXXmLrCrBi
         ZTA08ssFlkNpNU27tn/RfoiiT87m/SeD/xbMXDvQ84tRiQNj3B1HlFBnaZ+GVScdnbyw
         +eE9Z0LzvNh1qawf/LSlAv99nCboav6Y/d00iso0KpTkm1uZFQWetU7fDf7Ickx5V6OB
         snQYGrdLYIMhIohYVLX/Le9zlx5QBiSLfewZAZLmZ8bsNObwXIYPJqYhhcc1P//HW+7g
         Y6iRDGXIkWI8oiae6NYTMBeM1GXZkvP8fMKGG1m9rX/qgA1Mgs+lx5+43bEkNsC0nuZZ
         Xbcw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Giy5CX+l1/P8NyXsN84s5+4O3iXPuq+isIq1UyPBEsAE8mQu1jV/HcyqkYiFCGMgUCNtyn7WuIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5LCTkJgdcgNF266tyhrrsIMJCueWUzGzNSKsrCSB1eYjqizd
	OtjzbuXFZ6epeDeANrGxDMmvtqVDZfy1OOoGDuJcBxQXZFG89x+ESnQ7fANDiiiKsMmzgLOjNBf
	ULZH6E7hEtcknEMUDxyOnTH0yFmxtHjNuQSIShEvwV8RHO8OhPuDOJq0dtRxKEA==
X-Gm-Gg: ATEYQzzTw1tCu96Uba3Wei1Nltz/mVxts29BSRazAlxhcsTC0olCfJkUsfgmSIS7QDB
	uLqkK9PDpBPZZbFLQoNf3oksZ08SEpT2dLj7dp8xFdgcczEbXgSrWHGAgFeyr9HqtIzMm+L62/5
	nrgSYEe5s3GkEF1th4lUZl4wN68ukUn2xIuu4K71/CvA2rr4ScMzryUm3h4gNL1Th9/L6vQVdp9
	O7iHQlx4aJ8Dcs4zLjNXr83+pxre+K6Zgz5ZL19oJfK42nlGHIsD7CoJMffpp3fxn2cOqo6/7TH
	8SW3UpoLFz3/AESIl6mBfvTGtfQMLIlK2P03n4+FAU5ff1nG8ohGnDKSzLWrPGzT2NX09DJ/Hvx
	rYdZmCL107Nqgs/n73dplqcDVjahw6215rilsTt7bHUzre7ouGeNnV88=
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207129225e9.32.1773660256078;
        Mon, 16 Mar 2026 04:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr207128715e9.32.1773660255574;
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1215197765e9.2.2026.03.16.04.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:24:15 -0700 (PDT)
Message-ID: <2551cc98-5280-4a9f-8345-0a39e0e09dac@redhat.com>
Date: Mon, 16 Mar 2026 12:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5991-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10D052989FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> Teach TCP to grow sk_rcvbuf when scale rounding would otherwise expose
> more sender-visible window than the current hard receive-memory backing
> can cover.
> 
> The new helper keeps backlog and memory-pressure limits in the same
> units as the rest of the receive path, while __tcp_select_window()
> backs any rounding slack before advertising it.
> 
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
> ---
>  include/net/tcp.h     | 12 ++++++++++++
>  net/ipv4/tcp_input.c  | 36 ++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_output.c | 15 +++++++++++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index fc22ab6b80d5..5b479ad44f89 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -397,6 +397,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg);
>  enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
>  void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed);
>  void tcp_rcv_space_adjust(struct sock *sk);
>  int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
>  void tcp_twsk_destructor(struct sock *sk);
> @@ -1844,6 +1845,17 @@ static inline int tcp_rwnd_avail(const struct sock *sk)
>  	return tcp_rmem_avail(sk) - READ_ONCE(sk->sk_backlog.len);
>  }
>  
> +/* Passive children clone the listener's sk_socket until accept() grafts
> + * their own struct socket, 

AFAICS, the above statement is false, see sk_set_socket() in sk_clone()

> so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);

You can just check `sk->sk_socket`. Also you could re-use this helper in
tcp_data_queue_ofo().

/P


