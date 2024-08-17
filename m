Return-Path: <linux-api+bounces-2218-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9A958F0C
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 22:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878AD1C21079
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA22152532;
	Tue, 20 Aug 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tandagat.online header.i=@tandagat.online header.b="HpGFJ1KL"
X-Original-To: linux-api@vger.kernel.org
Received: from server.tandagat.online (mail.tandagat.online [107.172.211.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D218E34A
	for <linux-api@vger.kernel.org>; Tue, 20 Aug 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.211.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184657; cv=none; b=tJnbJ8yh73Vm0oEEwrrQrLJL4NFWHgds6AWViKc+5p/lJB56qzahEJ0IzMUDtvWr9QtXEJnGWOwUrLylSZgSOXN/iW9QXisTibuPqVopnyM0b3vbIfFNThs9JFnW4UX1aQY3Nt10OGZ6HBUgvQ65xjmGdsVvP9/5aCe3/WEfnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184657; c=relaxed/simple;
	bh=2WoKB0pMOk3pJDCrnvE2YmsE/5AcUKy7KHYgV/Mf3m8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGbJOJRC7Ms4G9n/nOjHU55+jtLLJAbUIMm2rrUAF1YSULTHuid+GZHeaXFX8upnRfz1A/doyvbxY9H+ObYh9d+yckMMyCwMPOWzC2iv9zU3hnRHXq1pFJKHzsMnG+xWEIeAOR63GMvoBzZtWLrqTnMfAvj9GU12QLRyj/vvvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tandagat.online; spf=pass smtp.mailfrom=tandagat.online; dkim=pass (2048-bit key) header.d=tandagat.online header.i=@tandagat.online header.b=HpGFJ1KL; arc=none smtp.client-ip=107.172.211.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tandagat.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tandagat.online
Received: from [45.80.158.93] (unknown [45.80.158.93])
	by server.tandagat.online (Postfix) with ESMTPSA id 875A9DCE3B
	for <linux-api@vger.kernel.org>; Sat, 17 Aug 2024 15:58:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=tandagat.online;
	s=202407; t=1723906699;
	bh=2WoKB0pMOk3pJDCrnvE2YmsE/5AcUKy7KHYgV/Mf3m8=;
	h=Reply-To:From:To:Subject:Date:From;
	b=HpGFJ1KLKsagkmazIKVbgo98Rg+cEHUmqtOjkgQ7MTxOZUWEV83MHFgsl8PzETUfo
	 Y7XxqSNhJHmHPgdtYYU+8dQ42s9BwBrRUp3r4bB6/91a66qHWhWMcYeEqKWcIbvQUj
	 ep6h+mb4yiEqUpwIQJGUk3yUaXrADIP/9o62A+9IVayNvU6w5CzGMDUjJxsl7ocQzj
	 LJq2gNp8wxX8SSJjQk5V+B15xnelOX80icO5oiI35vNdCsjA+9Ieqsd6FNc/8L0ePa
	 2j9tzisoAeIYvxvffiC1I/joVoJFgSvvRr/NRXhEAAt8lJqMxY7w7qCOxs/My/BecL
	 cOOpD5S3vwN6w==
Reply-To: careers.proclientstaffing@gmail.com
From: TFWP PROGRAM <admin@tandagat.online>
To: linux-api@vger.kernel.org
Subject: =?UTF-8?B?TWFucG93ZXIgUmVjcnVpdG1lbnQgRm9yIENhbmFkYeKEog==?=
Date: 17 Aug 2024 16:58:17 +0200
Message-ID: <20240817165817.9F8056E329227AEC@tandagat.online>
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
2. Ticket                  - Provided.
3. Medical                 - Provided.
4. Transportation          - Provided.
5. Working hours           - 8a.m-4p.m [Mon-Sat]
6. Vacation                - 28.5 days every year
7. Salary                  - Ca$20 per hourly
8. Contract                - 2 years. Renewable
9. Extra time              - Ca$22per hourly
10. Insurance & Pension    - According to Quebec Labor laws.
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

