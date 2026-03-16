Return-Path: <linux-api+bounces-5993-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ece7Ch/tt2l8XQEAu9opvQ
	(envelope-from <linux-api+bounces-5993-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:44:31 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E6298D74
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EE483009084
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 11:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752139151B;
	Mon, 16 Mar 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLdiH2iA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sH39Iz7J"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AA390C99
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661468; cv=none; b=i9fMUOkb0s1T7P8EHLB8nD9AMMazWGenrUa3gavqgy42lZZQZYysFeM3Oep937Lj0e6WyXNsPWZjS4MKnYXKLgLhdLNYNn/QgQt0DmV1K8pDDyGkyd5tGiXruAoAdDGC+c5y5BLNeQfE92fu9ysBJKHLOVOZg97M2pvixd5XIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661468; c=relaxed/simple;
	bh=XYZ/Z8E6vtXI8ekr+HAC+mYeXCVml7M5yCUGxNj3tfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQKwDn+qMCBDWnhVBifciQCahUjXrpXHs0n2XvWoNrOryagKB1jNf2qBIStOE36epm2oGl2xYv9giJMLJa9pxCyB69rabz8n37vdnhbT24sors7Rdq7b/ulFc9SfeAOgBxzCLPPQHyk7fvcD3ukYUgGMDq3+TgLLpQfLWS7wNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLdiH2iA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sH39Iz7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773661466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
	b=WLdiH2iA1Fj30KikWqsTr882TlmQNJPxWsd0yhTZuWtCrsmTWGoe98gePWbWrQ62SYG6x0
	VQGKKM1la8NrwjL/yG5UQzFfbbI/xKgbkJB1xQT0r5ntW+WkifUQzM/MX5IhIpbXwo2b5C
	Ls4NSIj5HCfVsA39eD/a2Dpf0JKsyYQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-h_tmx6gkMeC07pb-z1Jn9g-1; Mon, 16 Mar 2026 07:44:25 -0400
X-MC-Unique: h_tmx6gkMeC07pb-z1Jn9g-1
X-Mimecast-MFC-AGG-ID: h_tmx6gkMeC07pb-z1Jn9g_1773661464
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9788e5d72cso179993766b.3
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 04:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773661464; x=1774266264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
        b=sH39Iz7JhqEO7BE2yyd3VoO8NN5Sf/SVeBsxg/KeAiRczBZfWz91QuEltU0LeIBgph
         wXACfytY2IJTtBDn8D46ZjhbvqVecAcVtWCf9Tmcwk/k5PODKOMw72hprMQVMsI4LJrk
         YgDZ3kc1ljHr72WiKVDDv1fHqJajN3+gzQJNsFuJKkSXrzrnNF3K3uOMrg94aC7kD8ST
         aV69KkCmXxsB9+028EkCEzcYVkWHxFYad9gU9SzDLkE1SE3zTviemydUaozDx4gBRol/
         Urb6qZmgEnwiOaJgKS1sldpEqiu9Jl2ESxN4ppP379pJSTgTNRq590ou3jlrndb9sHgA
         xEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773661464; x=1774266264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjOWdH9YOd3q5jDpZy3h9DKwR4CFECAPPaRdY128lqI=;
        b=BtI7/eOFEIy2fA3E8Xph5Dts277LdhkV9thPjIcc1a9vhYjGtwOfWQTkK8jEpNM/HG
         S80oVxaf/CTO+1qnhFgSqOZq6P7pmgtMvlxRkgo8C4D1IKMt+fOS7K5kbUYOEssRKhbl
         CDUZVi0/lnXG4eniABQO70gCO3wX9SHs9G1z1RK7f/q9ng0A7KrIqXYSskjsd4tZ4Rxd
         vlfKgOfqXWmkjZ4405CNdHk81RS1llkpcul+v1arETX1WUeEIRVye/40l09zrVMuCw1/
         e4Rm7unugcasMn5zfYu96zTkadbtdyizblk4QBibY8xkK5qdboY3XvdrdoF5onbPpQBZ
         VFhA==
X-Forwarded-Encrypted: i=1; AJvYcCXH1R6Ix1elHQz3dK+bLqDizL8adyzi/sR2Fdk04HXAf9tIiMGkF+QktfMJYFkd64YRNDr89f0nPJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOBj9clgxO7OybHpUG3CDfSeB2O/w57GUym730Qn+i1ZxbEFg
	sG0/Eg7L6Uxe66bHPfOtE83LYRQzqv+rieJ2kmKVG8qt6NeI6N2LmzRmnXIXBTrLbC+esLwugtI
	RLXp1BdqeuL1cotFInkP4TBYjxPn7rXPwofnrQMwxVHTXRUwAjFrVId0RqM328w==
X-Gm-Gg: ATEYQzyEp0sJz/CwDC2ABUSNgTYt+dQnj6jwqV5pQzv5IIBhwH6WKg9gRmmo5vVs4c6
	iTuJlfHTTuMH6XHBsq6JNAokw1VAfwdOIUj9xvIDoka3yx8g9e+L1LzbMB1RGGhdAT8RT7/dOum
	S9Z6VGsiW84fOXQ4DeZDqaUgSe07ZJsEB2gTyehSN7nhHyGZ5qP5GsYRv4gV1ETOepz+HVb0FaE
	a/qYRfJ9zyoMJzXux253IOxlfluEAVlay4m+2FUR++4G3yQJkZjp9EkTWbTNhuFHtaP45wjmr16
	qRS0+NkuXvtLQ8/l/xCt4k6LwhQsA6WrsYwzJnNBuiiUcxYjk9OraLUZn2U0iiux56KEnITvbTM
	wNDuFCPV+NDqzotkNNkD5eE4gTeE7+23sIWR0RKtpjYDEbJ8iJ9fwxfo=
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285765366b.11.1773661463839;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
X-Received: by 2002:a17:907:3c90:b0:b97:acca:fcf4 with SMTP id a640c23a62f3a-b97accb064dmr285762266b.11.1773661463375;
        Mon, 16 Mar 2026 04:44:23 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d096d58sm533417666b.62.2026.03.16.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:44:22 -0700 (PDT)
Message-ID: <dddab568-a7dc-472c-8799-095ab96cef0c@redhat.com>
Date: Mon, 16 Mar 2026 12:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 07/14] tcp: honor the maximum advertised
 window after live retraction
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
 <20260314201348.1786972-8-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-8-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5993-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: C35E6298D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> +/* Sender-visible window rescue does not relax hard receive-memory admission.
> + * If growth did not make room, fall back to the established prune/collapse
> + * path.
> + */
>  static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
>  				 unsigned int size)
>  {
> -	if (!tcp_can_ingest(sk, skb) ||
> -	    !sk_rmem_schedule(sk, skb, size)) {
> +	bool can_ingest = tcp_can_ingest(sk, skb);
> +	bool scheduled = can_ingest && sk_rmem_schedule(sk, skb, size);
> +
> +	if (!scheduled) {
> +		int pruned = tcp_prune_queue(sk, skb);
>  
> -		if (tcp_prune_queue(sk, skb) < 0)
> +		if (pruned < 0)
>  			return -1;
>  
>  		while (!sk_rmem_schedule(sk, skb, size)) {
> -			if (!tcp_prune_ofo_queue(sk, skb))
> +			bool pruned_ofo = tcp_prune_ofo_queue(sk, skb);
> +
> +			if (!pruned_ofo)
>  				return -1;
>  		}
>  	}

The above chunk is AFAICS pure noise. Please have a more careful local
review of this series before any next revision.

/P


