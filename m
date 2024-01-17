Return-Path: <linux-api+bounces-517-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C3582FE84
	for <lists+linux-api@lfdr.de>; Wed, 17 Jan 2024 02:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631491C23CAF
	for <lists+linux-api@lfdr.de>; Wed, 17 Jan 2024 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121315B7;
	Wed, 17 Jan 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKqPz6hz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DACC7498
	for <linux-api@vger.kernel.org>; Wed, 17 Jan 2024 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705455843; cv=none; b=tmAbj0d2x0UPId948bnMJtwdBCS0Jm/78j7hjPIg0XTnVuahMFxYGVvCX6aLq61wDpOY3w8SLaJKsi9L86WeLxD6tanDc0CkGxHy0ZxMJ6JS/vGwVFn5pLadQehXKhIpS5iVQ7VNJpq+fcBFMyX4uUUcU+XMxvQK5/Q0LY8KqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705455843; c=relaxed/simple;
	bh=3Rc/iB6lpKaZmLswe3EBoqxgNQFU8aEwulkS42oghdE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=jwEkdkW6YdLhNQpsFbLW7MijFdmz0Xo6upAmgOKpMtblkC5qfOCl6pKukrGpJ2KviQWtFCN3YMFMX98nLGculH+kCYIcPUDuaD26KUKKA91SDMcIXNBcyI9o0OXHUCmKyGN3oH6UXHVXPA24JADmILuWlQXsz568SXgkQ8N0fP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKqPz6hz; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dddc655a60so5187112a34.2
        for <linux-api@vger.kernel.org>; Tue, 16 Jan 2024 17:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705455841; x=1706060641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=HKqPz6hznYnZNcSvv6+JRTq0qHiw2CjjJfH6j25HrK+deJ7ihcC9cmXhmkNxwPX2AZ
         SIHSwBltMqI4/dVjB19SRD+u7L+zGwREhe7yGBh0blNOwy+Nabn1ovYQqkNXD8T5auqA
         FNDfe2QJRQ92zgP3GjbXiSbIp7pklZp+F08xooi2n0v4tKMbrzy1ZGpdL7LDLpuXfapo
         n+tOQtC5ndq2MqjlIZ6q/XHlPpmudn0De4yiAGUTJWTv8QCaJjEP+KGz61GhPD6SGO52
         5tYNN48M3Fc7fg8nXKH/PzQlZWA4VPm/3AJUz0MRb5Rky4VZesjIk0GhOOVFFADm9eoi
         ktjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705455841; x=1706060641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCyW5jgYL0FNfi9sZFaXkPZnRkjGgNqTM8Cun5y6rJM=;
        b=nep5+dWutDSzrnjI1+KQMuKGUyE4nzXYYemwMmH+SL6gZNACSjKa8/OMz96fCLvY3D
         zZUN7+DhGt/p6M2P7m/JlcmAy8xTWKnLyOay1uEeoypYSfTax2euo3dhItTewLdiMdTE
         u0wOQkRqJdhMsP7hSs51gEN7//59hh1F8gKBLjtqNg1NN+kcmzyMitHoL0WftjiTWmC6
         Ue6VsttIl3HTHefA+7ttU1AspsK10IO1z5cN2tSOcHXjn5GTTd4fYFTNVPlUZ+x+Y9qd
         w9/x5ziHLjeMX2w1OPGDYmIDl49ocx4M586n7iDrZt1pWjVCVD7x02GX+JTlNoKUh0vW
         qbHQ==
X-Gm-Message-State: AOJu0YxlkcPr44zRZwL9I076Vt5OUjMb1EDEMb/qC+JE/YftrYr3KvvY
	+WKc4D3t8N5xxDoAj1ZgUmd0aN5uKCsFBnzZesifGh/77zBg
X-Google-Smtp-Source: AGHT+IGldAD4mdJNoJmIKE84COr9mosuz4vTOr5EHnkC1oq8G7bbXYyK0Di2ree/MvwG/EMobDC/p0sRp20Ly3A96M4=
X-Received: by 2002:a9d:628e:0:b0:6d8:567d:ed18 with SMTP id
 x14-20020a9d628e000000b006d8567ded18mr9306987otk.7.1705455841107; Tue, 16 Jan
 2024 17:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112074059.29673-1-hu.yadi@h3c.com>
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
From: Andrei Vagin <avagin@google.com>
Date: Tue, 16 Jan 2024 17:43:49 -0800
Message-ID: <CAEWA0a6CUh+Dma5eCPqM-2oc4Ah8jrFkeNgrB0Trr7paaUT6Nw@mail.gmail.com>
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, mic@digikod.net, amir73il@gmail.com, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	514118380@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:45=E2=80=AFPM Hu Yadi <hu.yadi@h3c.com> wrote:
>
> One build issue comes up due to both mount.h included dev_in_maps.c
>
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric =
constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
>
> Remove one of them to solve conflict, another error comes up:
>
> dev_in_maps.c:170:6: error: implicit declaration of function =E2=80=98mou=
nt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
>       |      ^~~~~
> cc1: all warnings being treated as errors
>
> and then , add sys_mount definition to solve it
> After both above, dev_in_maps.c can be built correctly on my mache(gcc 10=
.2,glibc-2.32,kernel-5.10)
>
> Signed-off-by: Hu Yadi <hu.yadi@h3c.com>
Acked-by: Andrei Vagin <avagin@google.com>

