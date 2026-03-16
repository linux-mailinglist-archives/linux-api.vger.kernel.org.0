Return-Path: <linux-api+bounces-5990-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHmbLrLlt2mzWwEAu9opvQ
	(envelope-from <linux-api+bounces-5990-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:12:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD6298882
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 12:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7B9304605C
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4E282F1B;
	Mon, 16 Mar 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwdQWneu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pg8DR4Zc"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C1277C96
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659380; cv=none; b=VVJuMYQmD24PS5kO4moA+/IYwyUwG7SpSEBguXE2MVUe3WBRvHnsMDSvtYD6BaCBvtiDXmHGE0hFJ9bMW8ZO3aiKbeCa0+hWFY8nrFfFktXDLPB9bdlSweIgT51m2Zz2bqfyy5Pye3wim2AHRkj7jfzL5yUSMlQiQPdsEqO7Xhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659380; c=relaxed/simple;
	bh=4jmmhwQ9HX1nE0wu5X/8gnKDvmvDMxjNyuG7KPrwFyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP0OYMjiJrGgs7oKsQB9O0EWl9MhHLs1xeDBjKTVHMfnNBKEcHdOlj1QnMzOZU1P+S+VYBtRWueCJayMdEPHiZ2AIf/xqXUtp3m6LOdkd5Fj0E2IWyafXu7okpBiGnSwU9oUwKACo9ufwRTZRXh6NeZnba+IVEIXcWaJXR/adkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwdQWneu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pg8DR4Zc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773659378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
	b=TwdQWneuxH+XPY5fg4W31LtUzZwvs9cfCZ9dRdFiRTRqPq5HjSQG3cmFuV74Ua76gsC4uR
	U0F1zxc2w6xIU79k5AOg6R2+CobJckyBOc8SM+sXtadubrjpU2TpI+f72fTtKOoC2vE5hb
	d+egVbs6e5h63Ek4ToRyjGYUzu8woQQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-sP_e4nuTN0OC7seXIugSvQ-1; Mon, 16 Mar 2026 07:09:36 -0400
X-MC-Unique: sP_e4nuTN0OC7seXIugSvQ-1
X-Mimecast-MFC-AGG-ID: sP_e4nuTN0OC7seXIugSvQ_1773659375
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b3011be7so3010610f8f.1
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 04:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773659375; x=1774264175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=pg8DR4ZciRU/ukhYwrOaX5lhErZFYQYqqGkF8dOZBruSptnLZupCiLBDh7he1CAsoj
         OwMo2wYzzCgoWmiCIDr5UKJUx+mOnWSeV9IdoW/xKbCXQIjXY/ewQ3ikUHOziqinGCbd
         7RakQrOrF7YGCOxR0brm55nfK4kwkQmjycIgVoP+C+3OTevfsvvFm0a9LAyZh/VDC3Qh
         YxlJ8WPAr2TO64ipKdC4jtOdJUPFAKZMDK5jOf9fJDDlN4as6ujUXPyjMEyCVKR04E6u
         l+B+2js3mM4UFo75FrSa6i6fCQb91jF/XifK9rEfDtdt8VNXav8ivTnHOfLkP1rukbFo
         Celw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659375; x=1774264175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJ1qCUPpj4bfVKkIIWkXXV0ps2+j94E+3GVF/7CvIho=;
        b=g0qsX0g2NsLQWP3uZpsT0lDb86qyAOAG7qeYdCyS25cjc6xjhtnmXxASlKlxA/5l35
         gC+gWZNdfXpTrJgd2YeJO8hIKrZoBEJXPE6nsI6XIFj9y0O30HlGuZoUFSbZHS4+ZrB8
         SnEsVsdxRQNfHbZQCs7NbxSJ8jN6vIqjZ0U18a7fvrhZiH1T2acnBlxx9cTzT55o07s6
         eYCLA254y757KuyTihBQYbfsknBL71umJWXnQzASBtAxgdzmZPcIimAzgjDR9LTeM5vq
         aZrnuvoeArCpETm2/lQbR2ne2UqKWZ6NNQ0N+7Q87hrGp0vZ/AqkXTQCRina6FtRrWDz
         6usQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPRkVpdHCTeDVaTY0Lj6kcORgWEFEDnrs5NRMV6D5ECAzYbkwK34LOB8y7DERgO3HcomBQr9h999w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmtjTDWFsv8kSIIyJtfZ2um128ZtDouHzjLHendbnaeT3jSi6
	637trVlqdlqX0lXDajXJQ0Z6/CNQU1UwmhKY70Rl19mhCRM/Fg/DW8lqKmErScjiCGM324UrRdZ
	a8WjauP375yqGb72ysjM9FY0btDOc1sOWXvPTrWyTfJEqx6DlZs+KELZQRK4cwQ==
X-Gm-Gg: ATEYQzxX7qhTkKq2Zu8xy7lmRM1r07lSdiTfG++9Vd3vsoG3kNqC36vZSX25+748Vp4
	7BRXJZeYmZw0LwXicIBfju/EnuwoSmQSUv7gKJuTQcZVpTte3Dme7cgsMzrG+7gqPLJW/TysrIF
	zz1XPyxOmaO3fGhqnsZlJyF0fDzZd7RRyovY2Sp5YEgOZwQpOmWKQV77F7KtDT8Z/ThGusN41OJ
	zOTgdGPya+JDRONiwdjatgnqCk0Q4ruAgpyXflYW0VxInLXf1WQxBGaqy21nFnrS5mamDexm1U7
	RXAaUnqiddvxOsmL544lqLp+92tkRh6ReD3yNFN6ztsgheAYMKCsaVw4JXwzD+57gBsOq/W5Kt2
	dC95zmp2hcVgVGPhDrW5OOF6Sziw2ujogSOG8sXArJvCX2RwkhgaogMI=
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211849465e9.19.1773659375343;
        Mon, 16 Mar 2026 04:09:35 -0700 (PDT)
X-Received: by 2002:a05:600c:a4a:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485566facc8mr211848875e9.19.1773659374904;
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73dasm1212991845e9.2.2026.03.16.04.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:09:34 -0700 (PDT)
Message-ID: <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
Date: Mon, 16 Mar 2026 12:09:32 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-1-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5990-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EBD6298882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> From: Wesley Atwell <atwellwea@gmail.com>
> 
> This series keeps sender-visible TCP receive-window accounting tied to the
> scaling basis that was in force when the window was advertised, even if
> later receive-side truesize inflation lowers scaling_ratio or the live
> receive window retracts below the largest right edge already exposed to the
> sender.
> 
> After the receive-window retraction changes, the receive path needs to keep
> track of two related pieces of sender-visible state:
> 
>   1. the live advertised receive window
>   2. the maximum advertised right edge and the basis it was exposed with
> 
> This repost snapshots both, uses them to repair receive-buffer backing when
> ratio drift would otherwise strand sender-visible space, extends
> TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
> truesize-drift coverage through TUN packetdrill tests and netdevsim-based
> selftests.

The series is IMHO significantly not trivial. Can the end-user meet the
relevant condition in practice? How? What is the net benefit in
practice? Is that observable under usual conditions or require
exceptional circumstances?

I think we need a strong motivation to merge this kind of changes.

/P


