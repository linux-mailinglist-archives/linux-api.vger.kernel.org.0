Return-Path: <linux-api+bounces-5992-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFT/A0fqt2mzWwEAu9opvQ
	(envelope-from <linux-api+bounces-5992-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:32:23 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBD298B91
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45A4D300C267
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749F3385BC;
	Mon, 16 Mar 2026 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/yymGbn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDppKzRu"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420229BD87
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660685; cv=none; b=d7O5WWfDa8vut+++kCaC5JW5PkhwG36ydPskKrn0dLNvGjaxhfVh3CKidDY0vbc/usf9BGmP4CiQZwjWHGGGcRoyyIJ+9f6Brf6oRPOgutbPzBph0KPsLBCPEkfLnXTCOII1nbF5TgHklvPdeyHjdqOIpx1sUa94776h3x6BEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660685; c=relaxed/simple;
	bh=RnzcoqiCgiO1PMBkGL95IiCkLD+8z6QAFA5shSuEMyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKCDgIcGMFA+3zDKxKr5SnLAsA3Ou/YvVh+OTa5g/+e6ao89s+fF8OFXs/FhbCtkeebIeBEaEkWP1htJD1x2v/DhzJgiy9cWoFglTp56NXhg+b82VOy78hNdpi69CMsshCJugR9ptzHwwAjHNu+qMxczLOFPaumWn2gAU4fyktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/yymGbn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDppKzRu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
	b=d/yymGbnR6Zo4Cp56EDz80mzlMy73/hUUT/ZOtUs3LWua/Nq+o1rsGONOBkzMkgAdn+rY6
	GVD5Ei4bDiHg0biABtDnPnmVWTC0PDUTLQ9q0teeZLXYoprPVZMrl6D77bBIo6Du8+uIsQ
	57JpZ/JmDN59mc/Zwze0R8yPmGkLerc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-MjneohntMZSTEGqMTCEEeg-1; Mon, 16 Mar 2026 07:31:21 -0400
X-MC-Unique: MjneohntMZSTEGqMTCEEeg-1
X-Mimecast-MFC-AGG-ID: MjneohntMZSTEGqMTCEEeg_1773660680
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso3807703f8f.3
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773660680; x=1774265480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
        b=UDppKzRuU7Pe/GCKKqNYcueBD/LliCnEK3jXMx4fh0840B2SsiFqRidgEEIePWreL9
         5Mf0ZttplO9N+IdusUXUFUS7Sv2fP17FngrSaqIcxDn3T+0tGaORf9IkRCm/M7yZl9TT
         wZR61g1b1LFXUEICy3rRgeQH69lsBzd8t0XA55QmuJVRFIxJ4a2nrT6rk0JuqrY52YuX
         l4YZaIqIEwY/xVvDXZy93egx2P1b3S7E/yxMEq+aGm9KImJOZFA8qX0NrdewW9Qar2jK
         K5lLAcJyXy32WtU+ohOVQL5Uv/3c0ZpxJMxL4reuLFykINnhp78lAJ4iNkORGmACj73r
         7DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660680; x=1774265480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
        b=BWb3rF8KjhVWhXCNXXld0x2GIIro3Zl2l551HQ63qgUoYFqzZj5gABjcecvwKY8RWY
         Awi6b4uwkUU0soUEbHjJCi7Xf401wBod+xpWe6JtM7X+5PGV0/9EuqYjDTxW7tCRGP+S
         7mHyah50Sn3NelJrZnIIw6SBqRRm/JeLlRrGeZ5C8N6dORluv7+W518scao4Xb87L5SG
         JVBR1Kc+tcGYnbSfjyu/TCu+vyVQBTkvY/MpJIDsSfk+8hg1uq+9soBWl+7ZksKdZHr4
         oI4zhK+1QYwUyWm6+8lf+EmITWpnmi4NUMqTMNC209UqlZSRm+8+dU+pR2h168j9fp3S
         GMwg==
X-Forwarded-Encrypted: i=1; AJvYcCU3aeXZA5sKS44o7csbbZ7HPmMFlpaJNSDeTpjGYN8R3aKorZ8vQsZ8tVvgu5vj619EEDO8g9f7sWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBm0N4A5q5KdDJgxvPPLuFbkkibGq8l05nitGSHoR0gJwMi+IE
	3eZwopnkYcauHhPPWpB6ryi3YGHLrrOt98LSBhk7zPfKUKgmuelMK4SlAUgFldeJ9/Me2+jX6Jt
	/6BJg1CpuwT5Mm2t5Ezjq5S9Uklc9VirkV2liKPkQxLb96gpqEF3On18h8kjtww==
X-Gm-Gg: ATEYQzwnAeNtuY/sLw+LewWP91Ct64+H5iftnYZZqXix3nRGTcO2rY5ifU6eAPfu2Hd
	qEpEj4a4qS7/K19JKQSGrhnqqFFVACKfcK4dnMRHYnP/FdTF+wws+Q9hNhBFRZBBgfS3UjsjYmx
	MPxVZviZ04io2etwggQYh97K72LGq0VzZfqz7mWWKjakHsp9Fh9FfYNA1O7dTYahbxDxx5OWwnZ
	4o1Mst8YpcVz1dl5XGtL5QuDPyCqftRK+PfwF11n+rQmnfoZPQUwSyzBvIh8AOp9t4kxEBw+W/G
	uUqwMaNF6lfNBfzOCVicIQiq3mM7uyt2l4OP0W06QvpRrWD480c2YtVG9KHWs3Sm8nYayEF35mS
	+o4fuj3hkdp+6z3s/J/O9IHZ5Oox3GCglxfShwrycZd8nlFARBHMKBJw=
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932767f8f.27.1773660680229;
        Mon, 16 Mar 2026 04:31:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932679f8f.27.1773660679649;
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2e2c71sm28145619f8f.22.2026.03.16.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Message-ID: <95ecd36e-e32f-4ca2-ba35-6d251a64ad30@redhat.com>
Date: Mon, 16 Mar 2026 12:31:17 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5992-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DDBD298B91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 57a2a6daaad3..53781cf591d2 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
>  	 * scaled window will not line up with the MSS boundary anyway.
>  	 */
>  	if (tp->rx_opt.rcv_wscale) {
> +		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
> +
>  		window = free_space;
>  
>  		/* Advertise enough space so that it won't get scaled away.
> -		 * Import case: prevent zero window announcement if
> +		 * Important case: prevent zero-window announcement if
>  		 * 1<<rcv_wscale > mss.
>  		 */
> -		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +		window = ALIGN(window, rcv_wscale);
> +
> +		/* Back any scale-quantization slack before we expose it.
> +		 * Otherwise tcp_can_ingest() can reject data which is still
> +		 * within the sender-visible window.
> +		 */
> +		if (window > free_space &&
> +		    (!tcp_rcvbuf_grow_allowed(sk) ||
> +		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
> +			window = round_down(free_space, rcv_wscale);

It looks like this can cause the advertised window to shrink even if we
are in the 'do not allow window to shrink' branch.

Also why the other branch (shrinking allowed) is not touched?

/P


