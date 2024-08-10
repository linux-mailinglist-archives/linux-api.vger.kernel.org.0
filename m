Return-Path: <linux-api+bounces-2167-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4E094DAFF
	for <lists+linux-api@lfdr.de>; Sat, 10 Aug 2024 08:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B05D2823BD
	for <lists+linux-api@lfdr.de>; Sat, 10 Aug 2024 06:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4BA3BBE3;
	Sat, 10 Aug 2024 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toneromala.space header.i=@toneromala.space header.b="pKR0/HSS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.toneromala.space (mail.toneromala.space [107.172.211.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F539851
	for <linux-api@vger.kernel.org>; Sat, 10 Aug 2024 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.211.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723269994; cv=none; b=YSIBo99R1+cqFz1H0Nsp+mo8xXbzv36kdGAuho452gIhCpG2qPPnq6v670SWmm++QwkAysILauDwGaTFnYg1BkCfrngBdx175D3C3a7hzrxeFjMd6mKMk5Se2FGoF0B3/2JuwS7nl3lZBnBKp+zwNK4pS9UXc6FNKBTx5bMGsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723269994; c=relaxed/simple;
	bh=j69zzRH9k/nQ1IAn2woSJ6H9IVQYL6Bv5jaLMBXKS7o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dl+4v7bPkX2Y7SbcdLgo7qGuHarEoIRmacg0PUBzD606x5kN+EVzOuNr5Rzlc3iYztMI3BflWwZY4aGwRswTEgeG+KYlsvtUSq2lQw87a2vmuOM4CGHYFhhlC3wUQKzjmccDAOkESJo1SOgirF+ZARiHgSggM0oGUSBEPQTMor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toneromala.space; spf=pass smtp.mailfrom=toneromala.space; dkim=pass (2048-bit key) header.d=toneromala.space header.i=@toneromala.space header.b=pKR0/HSS; arc=none smtp.client-ip=107.172.211.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toneromala.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toneromala.space
Received: from [45.80.158.93] (unknown [45.80.158.93])
	(Authenticated sender: admin@toneromala.space)
	by mail.toneromala.space (Postfix) with ESMTPSA id 1477DC252E
	for <linux-api@vger.kernel.org>; Sat, 10 Aug 2024 07:03:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toneromala.space;
	s=default; t=1723269834;
	bh=j69zzRH9k/nQ1IAn2woSJ6H9IVQYL6Bv5jaLMBXKS7o=;
	h=Reply-To:From:To:Subject:Date:From;
	b=pKR0/HSS8H9BwBl/yCMa3q8psIFdgpN16GS9TC56i1DifZiR65hAYIhqZcsHXALWg
	 3CTGfSJaoK5RlToFV0VfzR27EgdjrKWXFx9CkdRjWi7iQQxJDuU0zDcjU1Mho4s1OC
	 v03DKMMShxiKzZGl+1WoqNAtFXWHKfrMc7EsKRNqTTg2H+MoUdZ9GFFvZIqw4wlksg
	 h0UBmRX2bDo6PN+QiPxKJvytLStpxKqTn+cOAfdlX5ygvs2BtfP/XXw1gKUqz55RO3
	 oP0CLynmHnbcmCingwzGNRtDF2FbSeaCl6mXoXszmz3YQBzx+svOswpAiY8rZHK0Ef
	 NMuAHSHhfNHbg==
Reply-To: careers.proclientstaffing@gmail.com
From: TFWP-PROGRAM <administrator@toneromala.space>
To: linux-api@vger.kernel.org
Subject: =?UTF-8?B?TWFucG93ZXIgUmVjcnVpdG1lbnQgRm9yIENhbmFkYeKEog==?=
Date: 10 Aug 2024 08:03:50 +0200
Message-ID: <20240810080350.32E3F07743EFBC6E@toneromala.space>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Sir/Madam,

We are authorized to recruit 120 unskilled workers to work in=20
Canada on a two years contract. Please kindly let us know if you=20
can supply the same workers as my clients' requirements for the=20
following positions. Fish Packers, Cleaners, Laborers, Fruit=20
packers, Supervisors, supermarket managers, salesman/woman,=20
Storekeeper, Ground Maintenance, Gardener, and Truck Drivers. Age=20
from 20 to 55 years old are eligible to work, Primary Location:=20
Montreal Quebec Canada.

NOTE: No qualification is needed.

TERMS AND CONDITIONS:

1. Accommodation           - Provided.
2. Ticket                  -Provided.
3. Medical                 - Provided.
4. Transportation          - Provided.
5. Working hours           - 8a.m-4p.m [Mon-Sat]
6. Vacation                - 28.5 days every year
7. Salary                  - Ca$20 per hourly
8. Contract                - 2 years. Renewable
9. Extra time              - Ca$22per hourly
10. Insurance & Pension     - According to Quebec Labor laws.
11. Requirement               120 workers
12. job description           Laborers
13. Skilled required          Physically fit
Other Benefits                Family Status, group benefit and
other fringe benefits.


If you need more information about this recruitment, please=20
contact us at your convenience.

Your Quick and Favorable Response would be highly appreciated.


Best Regards.

Mr. Aiden Benjamin
510 Rue du Prince-=C3=89douard,
Qu=C3=A9bec, QC G1K 9G8, Canada.
E-mail | careers.proclientstaffing@gmail.com

