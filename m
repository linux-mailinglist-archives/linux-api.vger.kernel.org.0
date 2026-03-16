Return-Path: <linux-api+bounces-5989-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YASpBsvkt2mzWwEAu9opvQ
	(envelope-from <linux-api+bounces-5989-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:08:59 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A22987D1
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F40F305597E
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCC271A94;
	Mon, 16 Mar 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICET6ahO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtAnVNWo"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9C1C862D
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659053; cv=none; b=sCKEpJ/6JVxNY6aKZZPGyvqn2wtRTSLXc/fnbt65/GDqmJKhKUSIAOS07n9qRh2pDZpZmfMaoHFX7QPt85o+qmx3A1N1/keXhns2QPYwc1Xlg/lzPOMb1+BcYM9OWlZmMfdFQWg+XfAPU0v5pxEdwSLQ24fTP0OSP5D2NDjICUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659053; c=relaxed/simple;
	bh=1Z2K5uAxzV9s8L4/BC8KNuwonWVfjkCKvcQHutx8mBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JclFcotj0L0pqqiKZTR/fkvvBdwV1PW8a/zvZO8U81094/kkxdlgGC8xAbB1TTFBG+KyphwH+TW90k12xDX44oOviLP+9nt6sxAYOH5VMlTFnvn9eSew1DOu8+zQJAllSOPMKJBpqaDx1i0qnT/0cMJMA2JF+gR0Qcq9xj3nMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICET6ahO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtAnVNWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
	b=ICET6ahOcEmeSuifDilNtqfn6IujVNVMITSg+N695hw1weOf/TEE9NR+TROs2JM8Cu8WyD
	4RvKYifVMRb3P80EWCBsRXMRegfvwx5SWgy2H3jwY828vKQ//la3PmWgJus+I2rSKa5ziO
	WH5BvuHC4Pb1QQ9XdxyWwIG0tawGIVI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-xj3AHNekN-OgftL-QzM39g-1; Mon, 16 Mar 2026 07:04:10 -0400
X-MC-Unique: xj3AHNekN-OgftL-QzM39g-1
X-Mimecast-MFC-AGG-ID: xj3AHNekN-OgftL-QzM39g_1773659049
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b3a41c62bso1449578f8f.1
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773659049; x=1774263849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
        b=QtAnVNWo8RDAYP2tynSJuh1yaXc/I/KwuthId2CwkLuKRJ2Ky7ltkEerd2MdzITida
         L0tpSUOcrNABSep9Av9XKMsdGm24g4HXTRpeLv+aXS0vgIIiyfWTr+LpDxVK8qKNrb2e
         VkqUzEmlKoU6Tb1LiwOlxg2ctSE4SmWYO428jIcQsfpY9O5Q2REAlxsXpzZASD9INOZs
         I4gWwuIW6q2MBl2ybkZZHqQ2tOSmKjkBQyI0ld+L5YB8B15AzmAagP0GlK69bKLh/ocI
         EmGF57lM8e1L/Ww5Ja58yVJiBkt1+N1Q78Zmtb6Z6SGsuaCceIDHKZwr/CN8j12p0P3x
         oXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659049; x=1774263849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGzcfaMu1FLaomn7Oe2DL0qLnEzAPj3x2+LI9gIhWi0=;
        b=iRWvqz9if+sbMr765FsyUjHx7K5SRQJBWN+3/KSdvNhhTFHLRziElBqZT2EVRCJZl5
         jb9g/kWplKGoaLENcDLMhPARMRE5iF3rlXJsSBZD77lPHGlh5r9t47imal2AlQmI0c/g
         kStrMzuTYsoK1x5javvTUPqZMMRWyj9kgq7vP2Yh72+JcWUDwVcTqIaZmjCRSdGVT7mS
         4AXoY6vmbopNADvPpgLqec/zUMazkpnpnCfkREqs8aEbxM5CiYClw8yvepqifDiuT9Zd
         rx/r9WN1JSBSHqGYq6V0zB/id1KnzMPpeHbUiQDcdc9/bjegHVxdnsalv63TPyOnxZfI
         1L9w==
X-Forwarded-Encrypted: i=1; AJvYcCVNP6vh5o+VNc9IauEl/FCbtIgPQ71hnw7qgNxvfc1Z5OmCnEHU7AC62uqpV+gnsorYOsxn0DReueo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGXGX6gOLe6TCr/JWgluA5fh7ghQyi8PaVIokwHMGyia3PK/j
	awvBn2rODBwZnbT+lQTcNaEyY56MmSOVkpBL4JrlnYy1vXQo5goKbFgg+z2buUb1cumiXmH7W6l
	U7JHhrJeHG/VhnH4nV45NJlRZuBMcOSHoiv/j9sUZlkP6EI5RakhkznY72BbXEQ==
X-Gm-Gg: ATEYQzxO8dAzDO8rpUpe1lxhhqptedCBoQ3e3EzYsSr1RUr5Yt7cxPaNJ9htLAXwOr+
	RelmXRnIBQ39EFdxDcQVzYCq9abOrqCkVYRDyTbWNWknOzICVvn20wc2sL63udUzrlgi4q3YgtG
	SN/0510Y8mreCxsFL18PMOywUqI3AC6ve0pSLqOQLMZD8Gu8RFxJGgviJLQNCanP6p7TkbrZ4wG
	RAYTc5xkAV7Foh2vnbMVvlUNxenLfLU5cnvGURpmbZhYdORXwJ5jXom5wVNgRQUq5LkEdj/yWED
	kXdUI0KE+QliRx6kCNQFaaOzNsZrb/Tl5jYS4Uldyje5rESNarICGW/Nv6mNppiRirOJvhxFSGC
	E/ST7CiWWnjh7Zwup9Zm98DOJO+cJHXlH8rVp6wXTcDs2DleEYd7InxA=
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339357f8f.14.1773659049151;
        Mon, 16 Mar 2026 04:04:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2901:b0:439:b3d2:376b with SMTP id ffacd0b85a97d-43a04d86856mr21339273f8f.14.1773659048589;
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm41595197f8f.4.2026.03.16.04.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:04:08 -0700 (PDT)
Message-ID: <442cfa35-78b1-48f4-9565-e884e7e60d79@redhat.com>
Date: Mon, 16 Mar 2026 12:04:05 +0100
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	TAGGED_FROM(0.00)[bounces-5989-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	RCPT_COUNT_TWELVE(0.00)[27]
X-Rspamd-Queue-Id: A60A22987D1
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
> + * their own struct socket, so only sockets that point back to themselves
> + * should autotune receive-buffer backing.
> + */
> +static inline bool tcp_rcvbuf_grow_allowed(const struct sock *sk)
> +{
> +	struct socket *sock = READ_ONCE(sk->sk_socket);
> +
> +	return sock && READ_ONCE(sock->sk) == sk;

This is executed under the sk socket lock, ONCE annotation not needed.

> +}
> +
>  /* Note: caller must be prepared to deal with negative returns */
>  static inline int tcp_space(const struct sock *sk)
>  {
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 352f814a4ff6..32256519a085 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -774,6 +774,38 @@ static void tcp_init_buffer_space(struct sock *sk)
>  				    (u32)TCP_INIT_CWND * tp->advmss);
>  }
>  
> +/* Try to grow sk_rcvbuf so the hard receive-memory limit covers @needed
> + * bytes beyond sk_rmem_alloc while preserving sender-visible headroom
> + * already consumed by sk_backlog.len.
> + */
> +bool tcp_try_grow_rcvbuf(struct sock *sk, int needed)
> +{
> +	struct net *net = sock_net(sk);
> +	int backlog;
> +	int rmem2;
> +	int target;
> +
> +	needed = max(needed, 0);
> +	backlog = READ_ONCE(sk->sk_backlog.len);
> +	target = tcp_rmem_used(sk) + backlog + needed;
> +
> +	if (target <= READ_ONCE(sk->sk_rcvbuf))
> +		return true;
> +
> +	rmem2 = READ_ONCE(net->ipv4.sysctl_tcp_rmem[2]);
> +	if (READ_ONCE(sk->sk_rcvbuf) >= rmem2 ||
> +	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK) ||
> +	    tcp_under_memory_pressure(sk) ||
> +	    sk_memory_allocated(sk) >= sk_prot_mem_limits(sk, 0))
> +		return false;
> +
> +	WRITE_ONCE(sk->sk_rcvbuf,
> +		   min_t(int, rmem2,
> +			 max_t(int, READ_ONCE(sk->sk_rcvbuf), target)));
> +
> +	return target <= READ_ONCE(sk->sk_rcvbuf);

Same here, and more cases below.

/P


