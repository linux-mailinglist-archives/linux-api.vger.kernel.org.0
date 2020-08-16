Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF724594A
	for <lists+linux-api@lfdr.de>; Sun, 16 Aug 2020 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgHPTah (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Aug 2020 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPTag (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Aug 2020 15:30:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34DFC061786
        for <linux-api@vger.kernel.org>; Sun, 16 Aug 2020 12:30:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so12828097wrh.10
        for <linux-api@vger.kernel.org>; Sun, 16 Aug 2020 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0fU4VrqgZlTgwb4wRJnx5ZqxP+E94HxLzwK2cUn8RQ=;
        b=aRuBjBtfZr5au/mqaUr6qu4OjMSiJUdP7VIISIQTUUBlgts7MESDv0nEvlMnw91QMs
         T84O3kdAYAFn/LFeMoiYKLXrpbQD4DVEEIY2M09APJjpNONd7OkZBTBj6vwOAyDC1kMA
         hnIDEvpJ1PJ6XsFJ49fSB63z5Vi3KXLDFOxW3mq/Ir3tHVK/HJJck4lVFrECLVAYZyzR
         hpF8AiTOCXhR3zvAYMAhfMdeG/RPh9cMpCAz5zj9mZA9s2nAaZE9Ut/Idaqxvu295T6f
         Ri/QWSRpROECHS7Ob7FsQuoELa0TMJAflxPvPyZPdsMHoT7EuZYX5VMZXnz3yziDfVTC
         IWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0fU4VrqgZlTgwb4wRJnx5ZqxP+E94HxLzwK2cUn8RQ=;
        b=I2wmrNZli2NXkyQmT+M35SjES0ZFE8zOBT3cKLwlfV/napK2mnctMP5IYbiEBLnaEi
         nv9bolb7LDVFlL9Y8Z9Qnx2e1C1bMerLxfF3bdEOF5UBChrk3VVO2W0Qgd1ehtGYIL5N
         Kc2uUPqD1XMlDPJyJ32eGEVMUgRsZIQEKi1IP3Ga532o/I9+21efvVkxoC4u3VGxPiMO
         Fh7t6Gk5Ek3kXFOzzDTWylhMhOH6FLewaWzDMNyaWUZI8occQd0Y13OWl9r87noBMuoM
         sldxxvo39YHHGCrL6a+s/TKGeBZ+KntO+7AipIScSreMrMn4w7AeAS0a8ANLCoauv0DT
         juVA==
X-Gm-Message-State: AOAM5324TR+IA0SoA880EbtLSQ15J7SG3H+O8fgY3twe6y7Z9ZYcL76m
        aGNOMvtKibVj4ueYP42KyzVJNdWsBmySOHnYRBjCHQ==
X-Google-Smtp-Source: ABdhPJxNkrRRHn9VpN+44nPTclpKSsDITviwHA8cNDXLcS2RsmPd+jX7VEQQAPjG6X7ESHUZ0zXUKvaaNA4yeKqT/k4=
X-Received: by 2002:adf:a102:: with SMTP id o2mr11600431wro.319.1597606234590;
 Sun, 16 Aug 2020 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200815182344.7469-1-kalou@tfz.net> <20200815182344.7469-3-kalou@tfz.net>
 <7c910594-b297-646e-9410-f133fd62a902@gmail.com>
In-Reply-To: <7c910594-b297-646e-9410-f133fd62a902@gmail.com>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sun, 16 Aug 2020 12:30:23 -0700
Message-ID: <CAGbU3_=HQKHOzy_sq+gkLs-QDsQ4OmALbitaCvTp1hxVzAr_vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: socket: implement SO_DESCRIPTION
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 16, 2020 at 11:15 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> 1) You also ignored what would happen at accept() time.
>
> Please test your patches with ASAN.

Ouch, I will look into it - thanks for pointing that out & 3/

>
> 2) Also, why is that description specific to sockets ?

fcntl on struct file was deemed too intrusive - as far as fds are
concerned, regular files and pipes have names and local processes to
match against anyway
we're left with mostly remote targets - one example was to preserve
target host names after resolution (alas, I don't think there's a
clean flow to hook that transparently)
