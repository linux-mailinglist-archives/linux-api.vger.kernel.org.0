Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3114111857F
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2019 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLJKtp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Dec 2019 05:49:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJKtp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Dec 2019 05:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575974984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVctwGFkZUQARDKwSMhaffHofk1dC5Yr/3Iil1jZx9g=;
        b=GMjHIyRc0dCtRCU9zdHVl+7LpObx1yhX3W/Bs5MYa47Jtrt0EWswbpY4bpZ0aHeuhRCnGl
        l1aQXtgwHICV6Hc2fFZlr0C4HZISVqJ+z5LcIBZKjXCUo+PQ5GYy08LJc11+/tw4ni2yek
        QVCi9hM7sLoBh45lx3WuK0Oc8m2vbYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-E35hLEyWMqWnz6ENICE8Ig-1; Tue, 10 Dec 2019 05:49:43 -0500
Received: by mail-wm1-f72.google.com with SMTP id i17so866909wmd.1
        for <linux-api@vger.kernel.org>; Tue, 10 Dec 2019 02:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXqUXLfieW4TVcQp6EMVYOtM+vJyQwpyvlc5ef5/YKE=;
        b=QuSjuzAC1WDHJ2KaB3y+4BUl0MgwfXL+AzFjNHzBZn9uW6Ef7t84ZHHL2cWC88sKh/
         d7RkFD69T3EH51Xg6+OUfMr8yFyj0lO0qfSWvxC3kbC4ovSTZznTcJuf6fJW0gV3LSn/
         UYeTpNPacM8xy36nihCddosqdcYb7LLHZ87zHSge2temhGaxYVORBSJYZ9kj5hYi4gzd
         9fXNegMfvwt6k5r08mJM/inHoX7GXmRcNVl240OxhPAWeBtP1/MM2ypF6fchouXODxhz
         lQxEyRUN8ftEc+baduYP0GmkvxT+5CKQEGOrYxG7EddQC0GRc5QO7a4Cj6kTdH/Ds7JH
         2SoQ==
X-Gm-Message-State: APjAAAXc6k4YAbmE9qJzHTLA0iKsQzl2rpDEhxj7gxsr4itmdnkve8OU
        NOX+2xXyNQV3++RtOSV6rvLlWNb7r5kWFsKtDxPxdW89hE5B79z7DtEgUNQKdrnJ7O7N66W6qFd
        8Lny9YLcjtVcnf8FfaHv0
X-Received: by 2002:adf:a308:: with SMTP id c8mr943569wrb.240.1575974981380;
        Tue, 10 Dec 2019 02:49:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWrXqV875WoE1NtxDoSWnidAGuPO2VDjnYqV2h4y2diBP7Q+pt2V1baueET5JHkn8bVgrOpw==
X-Received: by 2002:adf:a308:: with SMTP id c8mr943541wrb.240.1575974981114;
        Tue, 10 Dec 2019 02:49:41 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v3sm2554817wml.47.2019.12.10.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 02:49:40 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:49:39 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH NOTFORMERGE 0/5] Extend remote madvise API to KSM hints
Message-ID: <20191210104939.jauw5hnv3smhtvtr@butterfly.localdomain>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
X-MC-Unique: E35hLEyWMqWnz6ENICE8Ig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello, Minchan.

On Sun, Jun 16, 2019 at 10:58:30AM +0200, Oleksandr Natalenko wrote:
> This is a set of commits based on our discussion on your submission [1].
>=20
> First 2 implement minor suggestions just for you to not forget to take
> them into account.
>=20
> uio.h inclusion was needed for me to be able to compile your series
> successfully. Also please note I had to enable "Transparent Hugepage
> Support" as well as "Enable idle page tracking" options, otherwise the
> build failed. I guess this can be addressed by you better since the
> errors are introduced with MADV_COLD introduction.
>=20
> Last 2 commits are the actual KSM hints enablement. The first one
> implements additional check for the case where the mmap_sem is taken for
> write, and the second one just allows KSM hints to be used by the remote
> interface.
>=20
> I'm not Cc'ing else anyone except two mailing lists to not distract
> people unnecessarily. If you are fine with this addition, please use it
> for your next iteration of process_madvise(), and then you'll Cc all the
> people needed.
>=20
> Thanks.
>=20
> [1] https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.o=
rg/
>=20
> Oleksandr Natalenko (5):
>   mm: rename madvise_core to madvise_common
>   mm: revert madvise_inject_error line split
>   mm: include uio.h to madvise.c
>   mm/madvise: employ mmget_still_valid for write lock
>   mm/madvise: allow KSM hints for remote API
>=20
>  mm/madvise.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> --=20
> 2.22.0
>=20

This is a gentle ping. Are you still planning to submit process_madvise() s=
olution?

--=20
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

