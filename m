Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699891D04F0
	for <lists+linux-api@lfdr.de>; Wed, 13 May 2020 04:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEMCaH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 May 2020 22:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgEMCaE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 May 2020 22:30:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F44C061A0C
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 19:30:03 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u35so4101241pgk.6
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dRl4YBE3TMl0SsiV0tZC4Iqnfxs3bO+Y25NzUvxt45A=;
        b=Xr8CCr30EpIbBzcUFmUdyJWqPcgRkkyRgJ8EuNa0FB0nt4+zA1favzlpTbLpHBYluj
         0/tj98qvnGqD/m6l/2oGIJwAffNk9yJA2BSCxn5LEmEWplcJ+dgJlXrpxRH8DRfcpcYA
         wS4eohtPzs81f4zWnLjkt0emvJ/qDc7ig6TaFCP3NwmZ7/3sZaN8dgm1FezAXzmmOjQI
         ApPtLtHQ7JZgaLDQnQwvgal1A8fGW8ejl+PqS9hpr5JUOw/pc/EWAF1PvYOmacb5uWWR
         pjZ8957+0ACJvt8MyHypjm/HHd0BEubrKizI9BTOATq0bJLhD7Zfgzd13UKC2FouaNPT
         B5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRl4YBE3TMl0SsiV0tZC4Iqnfxs3bO+Y25NzUvxt45A=;
        b=Ci8RgHQYC5C7c4bt0oH4XoCIoJBx5u0RiY440dkIAZxQehg5Kf8kX6kNU15V90muRu
         GSkZ9BgZYWygR+6yA9yGnuMoCrJIyxb0kdmMcMYDYoi5HolL+I7gRDk6oFNT3J1Ze+lH
         /mzvegJT8nqQ/YN7ghxF/Tcn3wkaUlpBr99yhhBwy5PO60jWXogW/qp0otMQczEa4CR9
         +5/f59S+sHNKXoJfx3i9nqQE3FLiuPk9Og2Ih/Wsuy3naqDuAMNUENVaIslCc2doruwR
         +XpIk3Z/X0vP6kIzPq4m8/Ac+pSQ6MlipIisUu8XLmi2epMUd8jo9RyQZ4dvJngSZntY
         K22g==
X-Gm-Message-State: AOAM533/dG/ejR1aQIgWQhpglfVhsmi4bpAt2S/5O7YqNTbf4+HhpTsM
        yq65we1HZjm55xysniPlrdarIg==
X-Google-Smtp-Source: ABdhPJwgw+y9MRoDkNWNDGa5d1jKOUxGsSXi+rxOaTsYZXTBVkbDWUxv6H3GSNMHgnPDg+ecwsEaOQ==
X-Received: by 2002:aa7:8c0a:: with SMTP id c10mr13866827pfd.177.1589337002687;
        Tue, 12 May 2020 19:30:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id g17sm2797521pgg.43.2020.05.12.19.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:30:02 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Martijn Coenen <maco@android.com>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20200429140341.13294-1-maco@android.com>
 <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk>
Date:   Tue, 12 May 2020 20:29:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/12/20 12:46 AM, Martijn Coenen wrote:
> Hi Jens,
> 
> What do you think of this series?

Looks acceptable to me, but I'm getting a failure applying it to
for-5.8/drivers on this patch:

Applying: loop: Refactor loop_set_status() size calculation

So you'll probably want to respin on the right branch.

-- 
Jens Axboe

