Return-Path: <linux-api+bounces-1908-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B792792C254
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E2CB29F91
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046D17B023;
	Tue,  9 Jul 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw6ojkf0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9517B020
	for <linux-api@vger.kernel.org>; Tue,  9 Jul 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543486; cv=none; b=W5PB1b53QH8ljJf9fR3pVa+E5Tvyj6PFuSdG1GK9jVDG5ENcFlBwE0olOxp0la7kzE2xUtrToxQVptqXyT/a8f28/Z5w6XkqYdzq7SgDh5Rl+juKdwgYA2Auzr1Zcsk3ZClJskz48PWmzS1nrFNrCixtCyMwpSIIQZoXKhAonN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543486; c=relaxed/simple;
	bh=sKMWfKD0a8y3lioSP7aEsIJMfJkjJGUBrPrhUwmrFLY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dprAQ8/yaDmF7HxmHdiS10MuxM+Y9OmjRv3e5ygDywy0ozT4gkNl+FRDee8uhPKaQCNQF0LdpjOSzaf8zknM4kcsXYFfFoggIGhEh9rrxhGof/EAkURx+8Xn8sWbBI1JjhM8Y3OW9oqYpxIoKkeE9n2HauRIaFjQ4D88yyp1BX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw6ojkf0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so22234961fa.2
        for <linux-api@vger.kernel.org>; Tue, 09 Jul 2024 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720543483; x=1721148283; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfVzzvPcEXh+9wtoNctw2ZP65S8MXvk68WvR8Ct5VlE=;
        b=lw6ojkf0RUEXMMdjJI9RUKRbmEW97VYGZ3FbGy88re181ZGFT7Ij6soHL9DMzKjBm5
         rBYAPsFErPXcjjjwVlBA4kQ2tqXlRfHUJ/OPBbv8uGfeonERavKhoJMsm9HoiS9K7g3Z
         A6SvchkR8XN0BhwC7GADuJ4Q96byXMXkFvCWG3ChiwUzOj0MJES6cJR8E640krlB+4lx
         TypjoG6BxwCiTHFiuQxqaQxVW0J32y4A2lIC3FWmsirwcTloWaFoTJDy79dPSYluNTO5
         93uOm5vkvm0QB4TYhJjv+xwV6bx3RKPpqlObcFIFJZ94kHoibnxSewhRcVS7x7jm63BG
         owHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720543483; x=1721148283;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfVzzvPcEXh+9wtoNctw2ZP65S8MXvk68WvR8Ct5VlE=;
        b=nzCab1cNwWThCQNiyvcK3XUtX/GW4l3RPkOfVBCmszPoccwI+Leh/gfj73euSj06MN
         5zZLpesG2F3dtsuWutt9rI9xv6E89uqINgh20/6JWGJrhoeyQMuGy6biNTCLmJVQEjtt
         T4BSEU0FdIPaAwtm+I519YR4tixOGEw16I92wwyDUOLU57D59wScSoNS/kTOlW3JJGL0
         gbdz7MROyhs8xgt88z8Z21EjKHZS1MK/v65xWgDkwc2DGg98elvUxiUm+h9d4T1VktVj
         19/Y7Yg4FTufjhsR8WlxUSVwmV/KDby0sQrKcfUNeJSWvPd6JPdkWvYdN31OzAJwGyDg
         Yz3w==
X-Gm-Message-State: AOJu0YztEwnPG9XEWpTat+BO24HedUWfw/OdO3L2NUm8Pc+QZPIha8Op
	HFf0WRzdAmNKPYujadCcBFF6y55OjhlDuujhh4ZuC5jxGCSw3LXw1qrMuw==
X-Google-Smtp-Source: AGHT+IF4jqE5kX4tM9jYTlA+BRxd2GoMdGsBQeknQ/qKyvSIzUYnDcda5nYsWPfkVSDvRR+b7bB4Ug==
X-Received: by 2002:a05:651c:8b:b0:2ec:4d82:9e93 with SMTP id 38308e7fff4ca-2eeb3198608mr20276211fa.44.1720543482670;
        Tue, 09 Jul 2024 09:44:42 -0700 (PDT)
Received: from ?IPV6:2804:431:cfcd:af15::536f:6e69? ([2804:431:cfcd:af15::536f:6e69])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2eeb33fff27sm2405201fa.28.2024.07.09.09.44.41
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 09:44:42 -0700 (PDT)
Message-ID: <f01d236a-e713-4953-be8b-1484201f8190@gmail.com>
Date: Tue, 9 Jul 2024 13:44:36 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-api@vger.kernel.org
Content-Language: en-US
From: "Soni \"They/Them\" L." <fakedme@gmail.com>
Subject: mprotect PROT_SIGNAL
Autocrypt: addr=fakedme@gmail.com; keydata=
 xjMEXwNi3hYJKwYBBAHaRw8BAQdA54PbCsby/5RoB/LcXM0ErtTf8Dg9vIlUXrCXz/Au4r3N
 J1NvbmkgIlRoZXkvVGhlbSIgTC4gPGZha2VkbWVAZ21haWwuY29tPsKWBBMWCAA+FiEEsMoE
 IRiJ1JxhKZryJ/4WYf4YmMwFAl8DYt4CGwMFCQlmAYAFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQJ/4WYf4YmMxGkAD9Ff/RRgDI+jEotQrJP5fgJECAUEeSiwquzAolp2ersZkA/1wr
 FdAe6U4id6efkAEtjfEJJ+GmU2vgSPXzqieza6kEzjgEXwNi3hIKKwYBBAGXVQEFAQEHQKmF
 MuXpl3lzDyXP3c76bJm1midZrosIYpAuoGqD19lYAwEIB8J+BBgWCAAmFiEEsMoEIRiJ1Jxh
 KZryJ/4WYf4YmMwFAl8DYt4CGwwFCQlmAYAACgkQJ/4WYf4YmMxgTQEA+UNWbiMf1MtDpP3Q
 B+HhsKvvRShHeYxkPgSY7lDicboBAOOz5E1jPI62uV0Xe2dM8n7TN+0zLw2fDXJlZFuCoVUD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

we'd like an mprotect PROT_SIGNAL flag for a compiler we're making

PROT_SIGNAL - marks the pages as unmapped while running signal handlers

this would be very useful, do you think you could provide it?

(not much more to say about it, it's supposed to do what it says on the 
tin, we want to unmap pages in signal handlers so as to catch bugs 
without causing memory corruption.)

