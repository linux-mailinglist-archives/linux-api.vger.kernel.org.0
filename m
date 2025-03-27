Return-Path: <linux-api+bounces-3446-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB64A730B9
	for <lists+linux-api@lfdr.de>; Thu, 27 Mar 2025 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A718953E3
	for <lists+linux-api@lfdr.de>; Thu, 27 Mar 2025 11:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837320F095;
	Thu, 27 Mar 2025 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b="qkCsD0un"
X-Original-To: linux-api@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4181F94A
	for <linux-api@vger.kernel.org>; Thu, 27 Mar 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075929; cv=none; b=nokQFWgHQIfKqUccDugYQb/V+l+mLoS9OxNyw+08fNfVm52Lz+8gXZK5x1qhPADqMFuiSEClgV4ivZQTGZDxZeBL8mKy+ce5vuA+WwscKUpRgZ+jSEQeEJzwplBLKXDL9yJFINOaHk2J7jBvFoe0+q+WSHIkkTiig/WaKW/jk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075929; c=relaxed/simple;
	bh=FpHhtTd+T++HYtR7Qbam/n8TvLyrY8TC5xyYZxOItl0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ds+HLT38CQbtyjbzjDrDR6Kq65WdAdyo+IxHhJ0Ia1OoLkXMnNDzu9PKDXnKVZn2whRtB4YfJQQnyRKLcBy74FCCwPisd5JJZLMiW9Jr6OISZ1uWUBEYAKVEkmlgz4C1JhvapfnYOiA+/RBSMKBcbxFpCU/O/Uf45nvMF2zLAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=radisson97@web.de header.b=qkCsD0un; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743075919; x=1743680719; i=radisson97@web.de;
	bh=1Bhi6Re/pwVWgt0JqReHuzkGhZSoI4utnTAG/6O20Xo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qkCsD0unSUhwiRaFDzUhs3boKGDoQHFCChhJl/bwpF+moyIR+dBW/S+4gTQt0lBI
	 8F1a2Iz6llQPbvTCLMUPWRmRrpeI1ko+OZNunUQWZqn7WezV9wjQ+V7FEDEINo9Wx
	 VYeUzbHj0Vuelpj7R1h8kJOsGZPyAtzkSEEj0pJjozDqSJL8Xt7QtMxrp6hiQAjhZ
	 yWxNHXa8UMzzaJKtMZhpL0JRnvF4a2LsHbWKFR+e8em7ZkKGYwi8DzdiC7R57feX/
	 06SH0aZsxG3PDHAkoVXGN9rss8nKwAUyGG5PPucu+iuS0biFdCeNSsbpzLLeegTE0
	 oLg7UdQENq3eO2UYPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.40] ([90.153.82.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxYX5-1tDTgE0BVh-00xeT3 for
 <linux-api@vger.kernel.org>; Thu, 27 Mar 2025 12:45:19 +0100
Message-ID: <cebbb60c-6412-49c5-a3a7-ca3d9663c2d2@web.de>
Date: Thu, 27 Mar 2025 12:45:18 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-api@vger.kernel.org
From: Peter Radisson <radisson97@web.de>
Subject: error handling recvfrom(2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vzHb6ZT3hyqttNQHXkG5jsk1Vg9V02aD7iXSkpy8RxLPG5xjp01
 NfegwgwbnzVC14Bbwj7d+QAH6ZPtiOh1tua2KkKWR4wmlfcpuJv/8t+mxsIC+31mQc/vTEG
 0U+umXRRCO5WM1ZLNFf3/K2h5U46Wf9nuPZ0rkH3HSrelJYzkO3fST4S1eGaKgRrD9ds/7x
 Dz5E/4IPwaGmVqHbBQvgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XJsGvjsOWt4=;tbA104oq4w1dsgP0NTq2QICTbuT
 bLQdW68aS1DmBhckBYKcAtijTq7mlzxJLMRQSQ94YH2OVa8HFo6h/kfmEpYTf4gKF0KI3UH5N
 jJ8PpnqnkYfMI5o/dA/Q9nqMNirB+4ccNU/SJ2m6jMb9yD9cSAIVI37ryhaN0Os5XSlf/hA5h
 2rcS/pmS9O3uORuzQ5kmEUMu9FfihcQzaZjTN2OdvEJ13LoH+jAKNz8EvzdmCVF0kVYiieDot
 x22WCld3MrUa8VftjP2jIxi8+bU/+bfauf8wSsDOR1zU8MP55BIOLfLO4ZrAz7QkaNukmiiKO
 Hm0I8w/zW7J9KZo/1eTgurRpSBY3ddhUB9Lc2MQHmp5bOg0QCb/if8cd6eXOWjdDLj1Y0/+SJ
 JMxED2HFth9bp5otl3Z3MTcgYc5Cqnl1LTeZlWAfkoxX7YKW76CtO8acvecJMjuCorDRwqBgu
 dfGqwj8/vsTpkhrdx74mMFyW4tYt7/WKpGSR89o29QkElKuCOU59oY60iJpD7Alrq/FA9nVYo
 U3buG9v1v9zumiR3D2K9bM4x6odTrvtvCptdrNkUncIQHdAHJosuUbttVmj7EKS8AOun9ZPm6
 9eEXNGqpyuVIn62em/rCosTFyMa+gpxHC+xu6FCkF2tZopGIaUFBluxUCrPEXkjJH8c9HrSCf
 J1dzJekU5vcLHGZpVl18ml238zdHVRYrwhbKI6Liz8XdEaa60EBz3UOn7DPpFjeTLwIZa06vI
 xHy1GLw1sn56muUvIX7H3nC+fRW19qhYgscrKN9TKyUia7hg0/lcyGPR0GeeBceQ2MVHIxqLw
 Jh3vkeP8NDgi2QkjnxcupQPgXKnSF5vQ9HJ74NyM1SVVr4qCtj2qX1AXQFNikSjCMN8z8Z43S
 IHWqxt5N+d3EHaFNRYixd8UTzojrlohrHgrJQD8gijxObA0OqiCJs/wTsYQ6arjJ4DrRihBxs
 pqYToTzYwpRkERmkHMWAj8WQrv+OGz4V3sDIAcHoVaDA5T255So75TKYjcNyiCjl27Iq4H4J5
 bllRbi83hoIV5bk9jSjRq/N6nhObugS1KjqCclrjVYnoO1UL/dZNp0W7s6FfJuUvoYU49y1k3
 B/18JyG6Esme8HnvISB4RKqmFV7ymuVCHsUsUUtfcSjwD1RLmzyQefZIM1QrgHSM3CDAAONOt
 iroqC/Pb9mCUNKmnpjgOAx5FIlvgotBBFfZ4SDoIbeoIFTmhFX7RFTks5jIREBpVbuOLaYAdH
 ys1w3nt5n32xKaIjtB1IDw6xQjijYDFTD6kcNIQBjZ657tX/lvfU3qFKsGJLP/Ry7GSO3pc1E
 OBaD1Uyr00hO+vmfittHxWSSReUltIWvTBQjPPr1up+d/9cGiL+Wd1yd/ourC/8qeSfHm68w3
 kiBu9EaX1N+0BNVD+K6w7uN3cy1F9hu4kJq62yCSXQyRf2EkRLAv9sqVQyfRWgXBqKXjQDJzT
 R4GJ0lw==

Hi list,

I noted the error handling in recvfrom(2) is wired.
note i will only talk about src_addr and addrlen in the case
src_addr != NULL. I have tested with kernel 5.14.

Function: the kernel shall fill the user supplied structure in src_addr
what should be addrlen in size (should be sizeof struct sockaddr ).

regarding addrlen i found the follwing behavier:

addrlen < 0     errno=EINVAL
0<= addrlen < sizeof struct sockaddr  no errno set

IMHO recvfrom(2) should report an error here also.

while testing i noted that the case addrlen < 0 is checked
after the call. What means if you use a blocking recvfrom,
the call waits for an answer only to report an error afterwards.

IMHO the check for space should be done before.

What is the rationale behind this ?
If not can that be changed ?

note: please reply directly i am not a list member
note: I send also a mail to the man-page list to improve the
       documentation of the current state

CU




