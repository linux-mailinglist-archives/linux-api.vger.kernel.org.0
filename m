Return-Path: <linux-api+bounces-2095-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF79455D2
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 03:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8880C283D39
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068ED7F6;
	Fri,  2 Aug 2024 00:59:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF861E541;
	Fri,  2 Aug 2024 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560398; cv=none; b=eZgiX8/hEMjm2z4diiPLbpfhF/BrpKpaVkatjhBXE8Ik4bq7wcFeRAXGsqYs5CEdwk46kb152SXLsZymF3az8EaIfR9SgPvkavyOZgYO+RWvvA6mWszXZ0vXDKsmP5R3LCaTk+VGNyZMA4UI4Ph+dp5tulHnX2RwBHdp9d/wyeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560398; c=relaxed/simple;
	bh=Yt1zTBSQabyGu+Xyv5GL52BT9q1FfWS0RHXumKUNkwI=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=RCJTUaAjujw9YiaQdRo3N22srrV8UhX0EJ5cXjaKXp6hVrHj+6aw2erF/uc16V+etnHxuY9pkALWSu3xitqzBmpAv9ssXXI56a2W1JzwYZF/Sp4Dl7F+7e7hgTD98fDCQY0Ig7xN7dczNVPJI56ASWMMbR1aFcPLgzzi7JwhV/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000010
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-XMAILINFO: MEKKfKJEJa0uhCsXNMenpPhPfrCjV0WmRNVafHz/DNtL79E5PWeJ7cZoegiVAG1Ji+brnkS3hZol1jFLm2luPp8i8laLSmzEBVrjPHMFRCYDQxQTbrRYMOdSwwCT/wkOQj9Y95d9u/v64thCLTm7Im8LW1TA+J8YMpkok5dZRU4eRp3oqUpiVCJ4wLzNWCCfOr/ZmnvY9NrR7Djd9Bw3sDd4zu2/srHw6UCMnXCsf3SRdRXv0L9x2OVk25fKjxuFZlGAOfWKXSX8a005/zdfdv6qxmRW6AUOPnOiRXBUgGGA1wIJR/X1CWcFqzs4wgYbjJ+FIFVCZQLbaik0OETwOXLV2NiF46V1odMUxk4NEmXJVItzp11DBWy1b5wxkspwhcQzHdhyVUuYdhahiniQbM1SOtz0mjsXWGjGuZEz7jl5FuhUCafUJqw4ynQmVLLFIbjGX8/DVIjlXPcGFq+j1xLSQA0vws2nkl2zcmTCMfkAje9Ue4A2NGEq3qZPhGa8rF7d3zhE1cfJuqPPX3834apXZSS6w/bIjxHqN43dH5dYAgKTaraBMC6ts82tiUc+P8i/Se8yhWnqS7ovp97oILg4nhegU+bdWaJzHAKKX8eEClizABQACKtWIwZvqXAUpl2AHcLDtE1WHDfKyyWYMKzHZGHydTeEPyPXS4022rG9hl4MTsbbTkSyObV0UZnAIJYLJTQ3hubWCJda2HYfVlkOvYhkCnJLgpQqTR09b+HcnjNgMM6iaP6UguHac26+Lily7gDTNoLNJLgqXWrwaPOSktk8NSmSrKKhA3yOtr0z2nTvg54XPbFtQBy24YDA2SS4FUv09Kpnusi3fPu8pity00ke8pvkhSREtn2Wy3wQ
X-QQ-FEAT: 3C1WcPM5lQ6i2sLB7YWRle+sn1bwZ2c0
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: wRXN/BysJN7QBAs/MNk0E8tp+1w3TNpvc9Pz/FMDv5c=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722560361t733464
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?aQ==?=" <i@andypan.me>, "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>, "=?utf-8?B?TWljaGFlbCBLZXJyaXNr?=" <mtk.manpages@gmail.com>, "=?utf-8?B?cGFuamYyMDAw?=" <panjf2000@gmail.com>
Subject: Re:[PATCH v5] epoll.7: clarify the event distribution under edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 2 Aug 2024 08:59:21 +0800
X-Priority: 3
Message-ID: <tencent_342AFA9D6460DFAB39B5C538@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
In-Reply-To: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
X-QQ-ReplyHash: 2854828946
X-BIZMAIL-ID: 1570632980442736828
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 02 Aug 2024 08:59:22 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgZm9sa3MsDQpJJ20gbm90IHRyeWluZyB0byBydXNoIHlvdSwgYnV0IHBsZWFzZSBkbyBj
b25zaWRlciByZXZpZXdpbmcgdGhpcyBwYXRjaCB3aGVuIHlvdSBoYXZlIGEgbW9tZW50LCB0
aGFua3MhDQotLS0tLS0tLS0tLQ0KQmVzdCByZWdhcmRzLA0KQW5keSBQYW4=


