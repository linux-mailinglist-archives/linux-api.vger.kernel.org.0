Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39121A054C
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 05:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGDbz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 23:31:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41110 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGDbz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 23:31:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so157129pfc.8;
        Mon, 06 Apr 2020 20:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/P6O2mPLymYKLroA3umPUfYVuh6HhhwYUO2JefWtMBo=;
        b=MnIaJgKNEoghmrXYeN6PrrfqKXrOrntj4ByA4CmVez3qiHobB7oQ3/xC3oPovq5TB2
         oXbeKgD9DFjurIty0CtyyM6l4ktmaKdQk1Ujs85ThzpCx0w1ZfbN7uTbkH3LapWXhdc9
         xOZIftUTzsIP47NhwXtJ7626WE3hccQLuImVctb7bZX1rq6Zh3nnBIb9RPWjWJZ9JC0W
         HQDSlvjiswN9LDefDZA/vDwUgo3TC9Q3vLCU68aHyesVXA1O3yarHqi4GGYNGH2lBj8Y
         YE5qMpV8wv/RduFpqvpx+PzhukZmLfpo+TWqnJqneFviyMCAufBhafr6goKfks9HBhAz
         lEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/P6O2mPLymYKLroA3umPUfYVuh6HhhwYUO2JefWtMBo=;
        b=EasDhZRlAkOEGIkw/oeUyKBCAbiqqEWtsHhgLpruBzxqRY/6oZG/Bav7OBUpiaMFqD
         r3qt4yO1NwcZK10eBcyIjZflWQFoxXLYJhUcLOAzLaTO/ucDdvciHmu+XcEztv3dcL1Z
         gIhXL4VrRt5TN+DmAdQuff37wXpjPBrw/Gb9tdDeQcVq3BgMUl4vHDSZYZDuym2lAW6s
         FA//T/Y4lV02L2lMuz8V4PLlCQGgl4rDA6vPTeJF1QeiXHoN1hqNRSGP1HqotRIvysxs
         HgiFjZC/RWgr0/oIqbXu0i0cVQuWFu0tJQ/OewS43o+wSPohPVXiB8nLCZ7PWxvHLZfS
         GF9g==
X-Gm-Message-State: AGi0Pua9Q3zvXh926/76LFKzIv8VLpBN1i+MyJu7IiL0xk2ChoMJIx9x
        D9iv4mKgZSljZRTGU8k3en0=
X-Google-Smtp-Source: APiQypLcGLQ1Z2J+R/kZ5w3OPbpyf/RIOgwvVgpoeBCWpfg3wYpUoe6QeCsb5QOAbl0r4tcef/U0XA==
X-Received: by 2002:a62:52d7:: with SMTP id g206mr615115pfb.286.1586230313668;
        Mon, 06 Apr 2020 20:31:53 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id l6sm4882192pgo.88.2020.04.06.20.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 20:31:53 -0700 (PDT)
Date:   Mon, 6 Apr 2020 20:31:48 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Dmitry Safonov via Containers 
        <containers@lists.linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>, stable@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Subject: Re: [PATCH] kernel/time: Add max_time_namespaces ucount
Message-ID: <20200407033148.GB494464@gmail.com>
References: <20200406171342.128733-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200406171342.128733-1-dima@arista.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 06, 2020 at 06:13:42PM +0100, Dmitry Safonov via Containers wrote:
> Introduce missing time namespaces limit per-userns.
> Michael noticed that userns limit for number of time namespaces is
> missing.
> 
> Furthermore, time namespace introduced UCOUNT_TIME_NAMESPACES, but
> didn't introduce an array member in user_table[]. It would make array's
> initialisation OOB write, but by luck the user_table array has
> an excessive empty member (all accesses to the array are limited with
> UCOUNT_COUNTS - so it silently reuses the last free member.
> 
> Fixes user-visible regression: max_inotify_instances by reason of the
> missing UCOUNT_ENTRY() has limited max number of namespaces instead of
> the number of inotify instances.
> 
> Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
> Cc: Adrian Reber <adrian@lisas.de>
> Cc: Andrey Vagin <avagin@openvz.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Containers <containers@lists.linux-foundation.org>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: stable@kernel.org # v5.6+
> Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>

Acked-by: Andrei Vagin <avagin@gmail.com>

> Signed-off-by: Dmitry Safonov <dima@arista.com>
