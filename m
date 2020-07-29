Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068C231CE3
	for <lists+linux-api@lfdr.de>; Wed, 29 Jul 2020 12:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Krf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jul 2020 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2Kre (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jul 2020 06:47:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128BDC061794;
        Wed, 29 Jul 2020 03:47:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so21170584wrl.4;
        Wed, 29 Jul 2020 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wK94wipvZy12QHdsgnIrWCRKfd/LxIY7DwkTjjpR/Yk=;
        b=Tgya0dv8V9YHXI6eXXudTH66utU+rO2y9SBlYsFHvW4J6cU4clIi1IWhPlm4dQlFD3
         l5Ppx0hDZVPdktF/+6+lWsEUYBZj5taMgsRlS8320DJLWIP7EIIzkWAUbJlu4Pz1L6Y0
         H4LKuCZK9mDVqW6mQP0hRYoU3Q2YM6+pIuw/V6u627/1q7EqkX2CkFzJZ22mDOfZO7YT
         GqmQTK2oePHArQU7ycKB6qU9nhDRloN+iqJuy45McY7r7QDl/KqESm5P/sn9+XZoeTDY
         HKV38o1UE7oGKXfGfg/AHEzVzBJYXYDi1Sv7cYzaZeTiE4ZCvEGeiqIwI9E1vv2vyPFL
         +AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wK94wipvZy12QHdsgnIrWCRKfd/LxIY7DwkTjjpR/Yk=;
        b=ne0AxFly5GKF95nuGjkvN3D+KrESCRdJTyC5Jdu7OTrY+xFgkBmu4/R6GkAjtZy4yt
         u2w8EVyljYPENQS7EUVr7TYHLmVFm5iIwRx1gQvl4YIsOYNS/4jUsVuA3lC24wZq103U
         q1zF1lKs2AZv/V908UCCqT/Ieh1TM/A9wEwPKRkwhgWUUjHfOzZPrbIGEEAmORPqEnJj
         w+C7xTKQIwr3sy2+31R7rOqwxTpjhO8zdHqZZKPBF+ixaZmI91xMPQH+50NegP50DevJ
         JZ7NONXqy02oP9oJHQv6VskjSSDcxn3m5TF0K/GahMOha2QL9Fwwy5b7PI79lUtuGgjv
         krwA==
X-Gm-Message-State: AOAM533fpo2O2JBF4hoNIHHzSQiTkDOaQN/DBqkCCidVLFyi2r+SfDYw
        Il4oQXWbmzri/ZFyj1ImiDXcnCMA
X-Google-Smtp-Source: ABdhPJwGiGlWgbSsztVOt2vL4N+N/f45f8ttrFeiuTsfylWxA5vWAFm+oqytsD9UvCnO7p69PvVOuA==
X-Received: by 2002:adf:ca03:: with SMTP id o3mr21349179wrh.330.1596019651636;
        Wed, 29 Jul 2020 03:47:31 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id g126sm4221597wme.16.2020.07.29.03.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 03:47:31 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] Replacing "master-slave" terminology for
 pseudoterminals
To:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, enh <enh@google.com>,
        Zack Weinberg <zackw@panix.com>
References: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b86a95ff-8662-60e6-dfa9-9d8d07a24576@gmail.com>
Date:   Wed, 29 Jul 2020 12:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> Eventually, I think we should take this discussion also to the 
> mailing list,

That should have read: "the linux-kernel@ mailing list".
