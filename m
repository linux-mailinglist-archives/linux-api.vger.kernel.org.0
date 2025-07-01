Return-Path: <linux-api+bounces-4071-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89923AEEC80
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 04:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFE517E590
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE81CDA3F;
	Tue,  1 Jul 2025 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Aht7CT7O"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBC1E522;
	Tue,  1 Jul 2025 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751337827; cv=none; b=p8vM/mnMqFcQh8GxBxni7tu44nHGQ2dONC/8FHnOEwONF2l5GFJI3sWXwV+goE4lmvDFVFJib0yNw1Pq3YtygGzT8CPEalfI1niq7HhAetvOS9ryNW0mC4O/+KPE6SxWtWHSKbwHGXHRBFEggYjt67nCCVg3Tc1KmPg4zAMFkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751337827; c=relaxed/simple;
	bh=65U5dEGmfX2mApXDVeyXjr8YGGs/V15/sn4CLFT0eDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eIkzDpDINv3gNMnGkAxhOtqbnZXY96YSzu/zcxXvAwqd+++bBzvrIsvAW7w46dZvV4ITu5NqTcCPJVIZd3v2TfTdzv5bHIDK9dIhqkcwvy11HKKX/V62qqOLEo0FfnobVjDGY616C0JiizrWup1dkGoxShE1rbQhuQwyO005dZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Aht7CT7O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D2791406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751337823; bh=xeHNwLOewM8sWl5+rQguP1bjnm0CgxWiz2pC1ZhoPU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Aht7CT7OmmeMhBFEQHG/E8gKFVpjWz02sC6135CoC0Mvd+7hA4RXwUF4usNYGwXL8
	 70Qt8b7oDql4PGHR5xNtCn4zpQwMpdGDz73ka/VfFi6ObZFqO2qzaJUSizLoW655Sr
	 7wwaShFwSvvsxV69aDxaiT/ljIQQMb8aG3166lpcT1QnHzbNasTtAnzs5mwrF1Bcn8
	 SmGHztDOoFq1LO/TVFAc+/eX7Bi/edT0THfLSvW9D8lKoRgAAdpb0Anwl0ujSOBQ3p
	 eTavpXVrFx5/H+oIW4ahoBqnlkMgbTk3pZJ7Rq3xo83IKaGQYuChqn1XMI2855iW3h
	 PWg7qBSh90nVA==
Received: from pelicano.lwn.net (unknown [IPv6:2605:59c8:3258:6a10:f9:f236:69ec:d90e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D2791406FA;
	Tue,  1 Jul 2025 02:43:42 +0000 (UTC)
From: Jake Edge <jake@lwn.net>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-api@vger.kernel.org,  workflows@vger.kernel.org,  tools@kernel.org
Subject: Re: [RFC v2 00/22] Kernel API specification framework
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org> (Sasha Levin's message
	of "Tue, 24 Jun 2025 14:07:20 -0400")
References: <20250624180742.5795-1-sashal@kernel.org>
Date: Mon, 30 Jun 2025 19:43:42 -0700
Message-ID: <87qzz0aaw1.fsf@pelicano.edge2.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sasha,

On Tue, Jun 24 2025 14:07 -0400, Sasha Levin <sashal@kernel.org> wrote:

> Hey folks,
>
> This is a second attempt at a "Kernel API Specification" framework,
> addressing the feedback from the initial RFC and expanding the scope
> to include sysfs attribute specifications.

In light of your talk at OSS last week [1] (for non-subscribers [2]), I
am wondering if any of this code has been written by coding LLMs.  It
seems like the kind of unpleasant boilerplate that they are said to be
good at generating, but also seems like an enormous blob of "code" to
review. What is the status of this specification in that regard?

thanks!

jake

[1] https://lwn.net/Articles/1026558/
[2] https://lwn.net/SubscriberLink/1026558/914fa4ec5964b0c5/

-- 
Jake Edge - LWN - jake@lwn.net - https://lwn.net

