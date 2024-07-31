Return-Path: <linux-api+bounces-2055-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3B9428E5
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 10:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95928284F07
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C631A7F83;
	Wed, 31 Jul 2024 08:11:37 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCF1A7F64;
	Wed, 31 Jul 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413497; cv=none; b=qMXUo9f2DooPcSa95KrJDjwtYay/Nk9siCOq5EJthOJDj7LTu8Yi9dP7nCmh648LlWPQ+evnicFs4OwiG+KeIzpDkH9zjCTjvwbMPUrwd+huI7Ks6vYQEXGm/iLWFB899GRKopiLeOnjpE4nD2tKCxQDotJDOl0cM4VVuXHO44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413497; c=relaxed/simple;
	bh=BypfphmwdnaG3QjNlnzsAMlpylDCxRuYZ6lhiLgq7eA=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID; b=MFkIA+S8GuKce8juqtpWRY6+AckQkccRKQWDsU0mlWSPdkN/n/f5dUcDQH+G3ndHdkSQe+8Dl9UjCHx0TQogkijZnp6yYSEndplATahB8r61tRapQ63+kBpGJOKn/lcvCLfOJqrtlSMuXkKjWe+jOnycXdQcqWkKLpbfEBUxRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me; spf=pass smtp.mailfrom=andypan.me; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=andypan.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andypan.me
X-QQ-GoodBg: 0
X-QQ-SSF: 0000000000000000
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-FEAT: AmBEVSWWrMdJ2Acbs8FXmFR/lFk8w4gz/Y5TrRMjvwKTQqtkyyOcPUPvCZlTF
	vSl5YpTf3hFnXp2aV4DMQlvdDkZPBx+eFlcFaE0Gm+HYWHtboJZ0npYbGgwUp1aAJv7foyA
	e2VBzyTqgAhBKIytlTEUo9kUj+wuF0+VlNHjvYWPPsfNp84a4gWh/v1jwHrQtdg9uPj3Ggf
	kWyLh83W8ydXlR8yFYpWj7PyU1F1RIhxoZKuXgAKVkUXO8uKLqYkc0rLQdVG01lWY/M2D2P
	9gFkvbOfkCBHEaW70lOcZvKUcl7keL6PXXb6qDyAuAYObS1ULPrLVpKyV64AQDOrtVEg==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: xR+DW9xn5kl5eHgjdafSzBos0uriB0+z2hyzw7Ec/fI=
X-QQ-STYLE: 
X-QQ-mid: t3sz3a-0t1722413447t3804776
From: "=?utf-8?B?5r2Y5bCR?=" <i@andypan.me>
To: "=?utf-8?B?aQ==?=" <i@andypan.me>, "=?utf-8?B?QWxlamFuZHJvIENvbG9tYXI=?=" <alx@kernel.org>
Cc: "=?utf-8?B?bGludXgtbWFu?=" <linux-man@vger.kernel.org>, "=?utf-8?B?bGludXgtYXBp?=" <linux-api@vger.kernel.org>
Subject: Re:[PATCH v3] epoll.7: clarify the event distribution under edge-triggered mode
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 31 Jul 2024 16:10:46 +0800
X-Priority: 1
Message-ID: <tencent_2654F7C90808524075EA4E72@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 16183467516893814799
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Wed, 31 Jul 2024 16:10:49 +0800 (CST)
Feedback-ID: t:andypan.me:qybglogicsvrgz:qybglogicsvrgz5a-0

SGkgYWxsLA0KV291bGQgc29tZW9uZSBoYXZlIGEgbW9tZW50IHRvIHRha2UgYSBsb29rIGF0
IHRoaXM/


