Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABC3127C2
	for <lists+linux-api@lfdr.de>; Sun,  7 Feb 2021 23:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBGWDV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 17:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBGWDT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 17:03:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F6C061756
        for <linux-api@vger.kernel.org>; Sun,  7 Feb 2021 14:02:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so6762807plg.13
        for <linux-api@vger.kernel.org>; Sun, 07 Feb 2021 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rF9rOEV9Q8WVIOH0rqIWO7EqANQSyBnp1ft+vyl9KF0=;
        b=QANXs0Ex159+byJKUEaE28kl3Xh1NJ9WQlAArBMiqR/LE0uHG9IpHhfqWrVmJbho7R
         zP1u0EqWhELbEmtTGccuSGqB1fhJqbp8L6ZAFLx9BsWQEpn7+9fUeq7ZlknoiHHfRYsV
         yCiSNhT/oz/MSrVIf+6C3avuFCznOmT2MIzTiHTudXkJ3md/uaNKYTp7OcY+zyFWUdx3
         t2hI93ykFPrRg/ziGbbX6FfZAddsJEzERu6Jadvk5KI3v/9ZrpWsV/zrUDO5Y59dlxde
         zHUljpHpBinHt9TpnJyq7p6CZXtVOCBYq6uXD8Si3ujOPNxK8fpJ1Q0naopg0iRuSxBm
         +jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rF9rOEV9Q8WVIOH0rqIWO7EqANQSyBnp1ft+vyl9KF0=;
        b=lkMXSE3HYMrMbCLQjKgK+WwLOca65mmmCqdXBeMclvO/gaiHzdXtGEbrpP8LiKfbcx
         3SU+wf7f7DX3/7iTV1uGEDWziwSTj06lIXd2E7IYOS6bsh7DaXDP87lINAcgDQYKs/J8
         D/mLb8uDrjJznxZG4SAGw8q2n5rqDJYtHiysEis8XbXaMJEvSHZ38Fo4Z7TDAgjXkfea
         +BwgAd3IU4NxXhAVC3FjHgnU4vll7paIgXWT1HMtUMiqp+Q6beV/ZYJevmm85dyKokTR
         CyTpRKVAcwkkbQTK/OsBL6SLbdz17RM2k4hYBbZZo0L6qyyE4bwyKiNVWaTkt5SkSQUG
         3JMA==
X-Gm-Message-State: AOAM532jJxRrPPGeGYyzCU+e4Ax1O72Md9qyds6PUJql+CDv3o2WDBe9
        7QzURdH48ks8e50qF3/C8123Pj7RNLtikPeN
X-Google-Smtp-Source: ABdhPJzNR1bzv/JQhWJTt0CBbMKbJVt9xR9k8FE58XkDiaugfM9e0sPAPw9t+dZ9eAqufWWfnMqn+g==
X-Received: by 2002:a17:90a:184:: with SMTP id 4mr13919868pjc.87.1612735358046;
        Sun, 07 Feb 2021 14:02:38 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8e8:e217:43e7:e032? ([2601:646:c200:1ef2:8e8:e217:43e7:e032])
        by smtp.gmail.com with ESMTPSA id i25sm16435713pgb.33.2021.02.07.14.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 14:02:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Date:   Sun, 7 Feb 2021 14:02:36 -0800
Message-Id: <ED58431F-5972-47D1-BF50-93A20AD86C46@amacapital.net>
References: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        gregkh@linuxfoundation.org, song.bao.hua@hisilicon.com,
        jgg@ziepe.ca, kevin.tian@intel.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, liguozhu@hisilicon.com,
        zhangfei.gao@linaro.org, Sihang Chen <chensihang1@hisilicon.com>
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Feb 7, 2021, at 12:31 AM, Zhou Wang <wangzhou1@hisilicon.com> wrote:
>=20
> =EF=BB=BFSVA(share virtual address) offers a way for device to share proce=
ss virtual
> address space safely, which makes more convenient for user space device
> driver coding. However, IO page faults may happen when doing DMA
> operations. As the latency of IO page fault is relatively big, DMA
> performance will be affected severely when there are IO page faults.
> =46rom a long term view, DMA performance will be not stable.
>=20
> In high-performance I/O cases, accelerators might want to perform
> I/O on a memory without IO page faults which can result in dramatically
> increased latency. Current memory related APIs could not achieve this
> requirement, e.g. mlock can only avoid memory to swap to backup device,
> page migration can still trigger IO page fault.
>=20
> Various drivers working under traditional non-SVA mode are using
> their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
> gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
> mapping while doing pin.
>=20
> But, in SVA mode, pin could be a common need which isn't necessarily
> bound with any drivers, and neither is dma mapping needed by drivers
> since devices are using the virtual address of CPU. Thus, It is better
> to introduce a new common syscall for it.
>=20
> This patch leverages the design of userfaultfd and adds mempinfd for pin
> to avoid messing up mm_struct. A fd will be got by mempinfd, then user
> space can do pin/unpin pages by ioctls of this fd, all pinned pages under
> one file will be unpinned in file release process. Like pin page cases in
> other places, can_do_mlock is used to check permission and input
> parameters.


Can you document what the syscall does?

Userfaultfd is an fd because one program controls another.  Is mempinfd like=
 this?=
