Return-Path: <linux-api+bounces-5934-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MI6DuobsmnjIgAAu9opvQ
	(envelope-from <linux-api+bounces-5934-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 02:50:34 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD69326C063
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7475F30C09E8
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087B035DA7B;
	Thu, 12 Mar 2026 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/T4HfxJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA9375AAF
	for <linux-api@vger.kernel.org>; Thu, 12 Mar 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280154; cv=pass; b=LPUcl4N9KtLeRjL/ddHEMmFWEpCrP+Xi6gcGzF6sOxfBUvJKPoVlGCA52MgoMoU3CoOVO8zhdyniIdTCw+MYNs2YGx8fF75RhnnAEw7lhrma2BZuB5Njue0UZt1/loLzqc65GN2rjW8WKCG5sesNBL3xVUGzK+8JPyidJv778lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280154; c=relaxed/simple;
	bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR/rZtSIQscelnnm7ULh2B2gSvNohI1LCuWcV6Zu+Ws2pouhWYe3hdLw3heUydDxNrVecPWUttH6fAuRop1g0NoXGOjnnu/C264TdJUGA4FXvbvvW6K76xuiA1Ew6CB3wJyriaNogfkanTPq9w9bq/oFeMoaN58smTt4mTrWp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/T4HfxJ; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506362ac5f7so4878301cf.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 18:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773280152; cv=none;
        d=google.com; s=arc-20240605;
        b=EsaxxLLFoalQatLho//EqxMyyHRTi94xEr4bmgCliTOuVOS2u91bYRrL7LssqnuB6E
         PT78U2rdjHmtVMqWibwxeqAOv1+yIGCjAYriUWC7PZMAmcs1kBlAB+wvhhuLIF4ZUoKV
         NCDOo36IyYcn8xBtpURhGxiEo+l8Y0zfTdYhQ7UUIEl6Uci/3teGv3b919so93m33+yq
         ciRrfkz7u/rXbSmwHFkb/ogImByTXR140vKhEBbcLUHY6okcg8DvqyHYy4ENfAt/u/vX
         oiw9EYX7nERtiwzWIVNNaaZxLkWfh7AxKU/jfIBQ58LXY093iWBERLc5LEjh4V/TqKtT
         mafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        fh=4mGX2m382ZHk/JIPz1p9ubRGAbhl/E00TpYMLfp/zY4=;
        b=hmBDXyav7GBIk/uZ6ucBjLFFq6GTY2/tt6aE59LQJiESDly62+4ks7tQS0B4U/dr79
         lfrQDoVg21RKeSuEs38Q8AoSl2b5TXnPSrI0NmzjQEvy+ljtjuBdgEQwEtNDBQ5C77qO
         2mhc51fB72QVCIMFy83DPPoUOkKidQ7VMvbTlk9fje/41jFvoi9VAFlVDyt1N9Q37ClE
         yIJGwPOjizUdKkkN9N4dJLH/W+hFDTX9Ycg8KR9CxKGrwlOywpGzTXdA3sLpB8e0r8xp
         QlD2ahdJFA2FJzb0nlmcF0m+XuFq3CQ0C7Vq1GRxaHJ2+dvxm3ZgzzR3yrR6YfYFC0RG
         qFKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773280152; x=1773884952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=g/T4HfxJMQw5J3/IjSdky+zVHOmQsiCKoeovleUvx5h1ws9XT+AIGwoKgoBj+a42Oj
         CPNuouejDGtkNvppsigpAgK/YsDxUHQU9JHbs8bcXEf3feuFlxUkGTriWXeXuy1oJ1dV
         djrRDgmbUP79RQWKoIT+i3Pz2IpYxxM334cZBOzTaKiq4z9gdtmY/6se4G+bQcqkHyWd
         HmqRrq3yp5FK18ciETnIKTki+RA+gMRyWJteFhAUzW77kYRFMp9KkvDd9tsspUUm6wZL
         Zg0fvr9oOpuJcAblDYYO+GCiDiLkW2ZT1yiaBnsjGjl2nN6vsfxPU6Lc98Rx+EC3W8xL
         Ytxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773280152; x=1773884952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=q6VZvAoviZMoA35oHRpQ58r5envtN5fk/Y4VYWMU5PhnThlhJfPOQ9Zep+HggpAO7X
         GW2iGnnVPOPpe145YOSb3ksGRLS/1QzFnQNvyHVBRMudHBkLYt/I0kWmVK+NLeBU7KNQ
         g0M5+5CBmiLsPwok4zoeY6bOQ6+TlUN0dahgpUbRKT2Byh1No5hbZVSNOVQIhamNMa6i
         aIkDS0jgr5YLk0CymchvTvLqwPhG8i2YEwaitz1F+gYY1mFwokwuiY0clU3Wk5wHfOLB
         t8awNpalNyo08+qc6U+RfgWEoMMfE/bVGCXCWaLFMNRvbUz0joqChQ4e+ZEohilrp2xX
         SwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQN8ZlUHqmaIrg1qnL8THpvZgR31o8KS98q+2l7zDN4GjOmOoaQpDLAHIXCldz2LNzGvY/BaDWGwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SwfKY4B6RaVnKr8faazqqPBz5wNx14ebmf8hEHNyS3/Tx4xV
	oA2XpWH+f83ZJyEk8D+PGq0SqwF5Lu/pbEHjtsc3NsL1mvvbnUFtAGvbd4pYlesbi0ipyFFkwC0
	dPVHZntxuNCz3zbCJPlzrEcESEoX9BWq6gvhQkNm0
X-Gm-Gg: ATEYQzwPwznknk/4ohwdEi+r8fK59YnezCmXiJmIx2JbWCJMY3UbwSCWnKW/bWl2NLN
	eJ+QP4qFPPA5jA7Iovy+9M0Gpz9/kcsZpDRiFViF1LQzvt4CSJloHR0D7oe7nxoy5KINi9uyeVD
	tfmr8WCFqUwiQ2ThoUGGjW08zBy2NyTSHy44cMu55VkQpodnwsCVjApX2s81RONYzJajucl8YdR
	a+u2Sv9eP8yh4aBtwAtCZxdXxCp4drxanQSvXyWb7/MP7n/03swBUonhvzhK/nugBAv94e6aDl1
	8E+plJU=
X-Received: by 2002:a05:622a:245:b0:509:16ba:d537 with SMTP id
 d75a77b69052e-50939fc6311mr62588591cf.19.1773280152190; Wed, 11 Mar 2026
 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075600.948413-1-atwellwea@gmail.com> <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
 <20260311174154.5fadb207@kernel.org>
In-Reply-To: <20260311174154.5fadb207@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:49:01 +0100
X-Gm-Features: AaiRm52zaoXRZHJbWhVYmknx0ZhJd77Ysbeej4LqlWfvsr4aOTCUEXNpCukM3UU
Message-ID: <CANn89i+8LBnbwGE+4qfXv3uKrwLXog1hXqabSK57dCABJ6Nx0w@mail.gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, kuniyu@google.com, horms@kernel.org, 
	geliang@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5934-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,redhat.com,google.com,kernel.org,vger.kernel.org,lists.linux.dev,lwn.net,linuxfoundation.org,goodmis.org,efficios.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CD69326C063
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 09:34:32 +0100 Eric Dumazet wrote:
> > Your series will heavily conflict with Simon's one
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1063486&s=
tate=3D%2A&archive=3Dboth
> >
> > I suggest you rebase/retest/resend after we merge it.
>
> Would it make sense to extend netdevsim and packetdrill to be able to
> exercise scaling ratio a little more? Having it optionally clone the
> skb and truesize +=3D X would be trivial. IDK how many bugs this would
> let us catch tho :(

Yes, I think we mentioned this at some point.
packetdrill uses tun device.
Adding a TUN ioctl() to control how many additional bytes are added to
skb->truesize after tun allocates an skb is doable.

