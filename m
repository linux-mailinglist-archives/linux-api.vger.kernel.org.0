Return-Path: <linux-api+bounces-5998-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHsWDAJGuGmLbAEAu9opvQ
	(envelope-from <linux-api+bounces-5998-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 19:03:46 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469129EBDA
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 19:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80AF53017014
	for <lists+linux-api@lfdr.de>; Mon, 16 Mar 2026 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D433CEB0;
	Mon, 16 Mar 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O07WQe4D"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EC33557B
	for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684215; cv=pass; b=VSA8hmlfTr5EeOleUMfRPPUXfHGFbDUgUUf5xeq+ZQQcO0czQndt37uO5ANsfrcKdg0zLmM98Q2ND7HbTpDU/3SpUCExKn6i9xeWY8D73Hyymgw/bBsPH+P1awfP4ByuwyCx3sJjQdyHYNWojj0mICEaYQV6WxzD1XSh6EU9/RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684215; c=relaxed/simple;
	bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJHV0UvQfQy1bC6y+RVF0QTzBO+7H1OM2JQmiJIIcdHGG/MlInkIGaBJE6iorVaNohUyfiTbFB14wL1Y+t2TmXA8Z+9BF7KRf4AYR0kK6cvytf/rFy92oe5oXxflEZTGunQPdV0n2GdHq4neM9BgCnuBZZaWRXOWtp44kAWgzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O07WQe4D; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12776bebe9fso233562c88.1
        for <linux-api@vger.kernel.org>; Mon, 16 Mar 2026 11:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684213; cv=none;
        d=google.com; s=arc-20240605;
        b=FF9CqIeMvD0DgypH287n87y9ZFIkblPNXGjvLuK+VtVbuAfTjirAn6HjtCCNE+CPBe
         m36nFkYZjtQDvtT3rk9L66+fKpDt8IdafKVr3dOZGodHmEciPfWzE09twp1U6Md3Mubo
         w3a2zESxJS6HEng+rKJICTGSBKRUPQmq4Eu6SrqybzSh/DtwY/VzKEEa0h0rXO2ebRTB
         gR4pm/anTBx630J+7yYNU5HH6U/AJk+fwWEiz+rBr1JBZHIdAX/wc/8CMiXCC2n31+4l
         kDxyeBAptqDP2oTzojfMX3HL6im3zh8+pJPH1Rs/hB7GnWpmq2KDPCfDW9Wmi87adBfF
         bWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        fh=AI+S9w71Y5h4am4vpe+m27qMWHlN4wTb4I03yfVxLUk=;
        b=b6dmbJrDtQbX/1gfnDVN63aJCPID7pGZmtNh85xmGcBlo75SikYiX47FNvumZui5Cd
         IX6RJRikoN5VtMUkC3Fds4fXDFHAS8JWAcFvBu7vhsVUB+h0Y2xonYXxAvToOsJgpBT8
         4iwLv3fw/s7hPMjLd+rbufgDaDGWkkx+FkymsWt+zYlMxPU9Fybo6ktvoarhxoGfbrfA
         VWXNiTeaHCvE+jgKdMp+t6VlYkto6A0XKZgFxesH7o4lyT2ScHxc9wS7UNk5OnJg7aFf
         WZI9oNCePnhupNhV+BG+4bySITcjFeu7L0dqgR3Kq2mjYVMt6XQe0a/7VAe6Y3cpvwlA
         bA+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684213; x=1774289013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=O07WQe4DY8rR2TalssFliMhJMUanx8+Nj7/aoptmrFfrw6TU5RopcWFn1u2FSG5wj6
         WJdIdUVc/Jz6eCnjmFHsBrDLej9HM6xxU5LSAYT7wY1Nr5J1bsnTeGfQSWq0kfBKqxrp
         XvwlEB7du/N87ct4LCBjpa9pnRhybUocVzNtb6uI5T8kJQanDtMKVR8UhHxsl/SADP5T
         mzxmC+H2Cv7X9Hwrvl0HMDq4KajhQK3qoZVZ+9UoKOeh3YY8ehoAS3oRIrSqQ7/gFLMW
         2kRGTnGFAmkfbrRP7PH1q65ynTPsQ0glkjdQYpyB7zlLTEroJput4cJbSf77Ec7xTZ/n
         vr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684213; x=1774289013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNzIzyFdGwoJAVx7hy0kRK+gY5zPmTyPzd0Wd0WQTas=;
        b=nPikICLAnlwKh0zybeA/g6RLZeOdSuwMTTZDIRgFUS7UXuEHrfWkdUhcXvs7sFTVEr
         fjxfkWlhDupnPeSH+ey3T1H1VMJQ2zOW/ysSMh/qSNdyg5BmU5WTjEWNihypvLpbMw8f
         m+AeF5jcNW15DNoxJP2ScZBoZzYyFnCC8vyqEicLgQT7xZwW3GgloZlqDwCftIFIzl6D
         MULCP4pDhPRkKGzcqbISKu+HPdBxEVcHbwuShq0Wiv06h+YO4Nfd82Ywg963S5i9TBu3
         29dqnOv4HzoKUAYUX28KPy6wRMJpPrGXHkA4UYNN35HJnX621OvWUl0Pg0i3bg60sa76
         7tfg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ImM2i+Zyp0r4jVjTmTPKHXsv8tdYLK8YkKQN3OBYO0dWeXzqvHDSbk2H/qdxhSHXNv6htUaAesw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywej1II2E7zBSqteOEnbwK19y80fS6sg2waGuGMn+rUs/FyOwAN
	Bf9cML+6xVugWTMoVBs5TM/snMjezVsAC4C3yXfP8om9qj29OhYlkC/YEDwn3XP3mk43kyvj9v7
	7Jlg66+hbPBkvcomxGpGyruVEUrXtRoo=
X-Gm-Gg: ATEYQzxe6nufLidL8Y0LckCrOKV2rAHa30EWfMWUg03bGLJOXR2bHtQhI1j27uMscZV
	gzUr/FR96T9zEzUK/cRBscj/3ZIDaCNr2RMQTujkUrmtvMqDJcyXFs4jNAF+UX8FrbP5ozeRe01
	hyjEqkTbspS6o3GegszQdIFTctyMWbjHJqdpb8bahhLgi+Eh+GEzE9NpkjBx7rweUCt7DijkLsi
	jy0nG3kBgSMsGzgng0J0U0fOQGGw+Ao6/46Tb/1EDlz7ba1uYRB6PBFIp4xIuczV3SXec9GQD57
	/ghNSSUcfY2uQVRRSfzuu1gWF7F0b6MytlmwZFWA
X-Received: by 2002:a05:7022:e1d:b0:128:d786:8aca with SMTP id
 a92af1059eb24-128f3c6b032mr6448350c88.0.1773684213034; Mon, 16 Mar 2026
 11:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314201348.1786972-1-atwellwea@gmail.com> <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com> <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
In-Reply-To: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
From: Wesley Atwell <atwellwea@gmail.com>
Date: Mon, 16 Mar 2026 12:03:21 -0600
X-Gm-Features: AaiRm50ReSwavo1j1ssacOUbWxtcgznlHmGlPHkMg2HYVcwTt0DGLUUEq90y36c
Message-ID: <CAN=sVvx8jNC-OAMkv19Wv13jTpV5_wVEabwUCjPLMwTvS4czow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org, 
	kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5998-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,lists.linux.dev,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3469129EBDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

The link I meant is the netdev regression discussion that led to:

026dfef287c0 ("tcp: give up on stronger sk_rcvbuf checks (for now)")

The report/discussion thread is here:

https://lore.kernel.org/20260225122355.585fd57b@kernel.org

The revert posting itself is here:

https://patch.msgid.link/20260227003359.2391017-1-kuba@kernel.org

I should not have implied that there was a separate prior
regression report beyond that thread.

Thanks for the note on formatting. I will keep follow-ups in plaintext
and avoid top-posting.

Thanks,
Wesley

