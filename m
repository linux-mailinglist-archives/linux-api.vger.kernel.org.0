Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235071A054F
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDGDdl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 23:33:41 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35914 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGDdl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 23:33:41 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so170448pjb.1;
        Mon, 06 Apr 2020 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/Z+1EhzPKH/+gfsWTS8RfxVvrjmpU0UXINubSAXsU4=;
        b=X/zRB9WhYvcfUKxGIE5qtnjlusjCpiEokIO2jk8OX71FC9c0apvw+FTHWDkekRGt01
         V/okEsXmgjLwNaevfOAqS8dV0Jji+ykoU2gVNgtzHxlEJ7peVucFhOAj0EV53Nd4DvKr
         7ZL5SScqMLPqUXpIQunZ2YmpU0+/Gy+ukoRbt2zTwCS5a161ygE2cby2/+bT52hQ/xT3
         xTRCop7JoA0oS22vy1XwAkaQvlKPhko4UxpXIsGTI41L624in70wPAzCLWTThShdr356
         LnTBsUHZL58BCMW+gUW73jjgf6gsob8OhkJLC2QoVyXvxhBZTrXUBz0mwHF2xH6vylYe
         q6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/Z+1EhzPKH/+gfsWTS8RfxVvrjmpU0UXINubSAXsU4=;
        b=AlH1c/T0wvl83trtQJvjRgv0R97d6AUUKFhRAalEEDS7T+9+K+9wToadC89852319k
         DDRt66mdd2oywPjtGfmMjLQXKvnLMZqv+rVLNU2DsKq31fAGSiLD35UOJ/zFL4SF1imP
         b7dDpU0+JMf5J5h3nLfaW03zTr/uNwyr3NxgAKcpffzEcSnggy3iuDX79p68bQyFzmE+
         /ivQGB7kpA0IEpPwt1kksVbCry0MVqP7qwEL3bc3aJmuNq9rM7NIXODUCsP4lrWCQMXA
         EeM1+anwhPpHmBmo+4IYqyF0SOTeDMbS753Znqf1hwTzGWSiSqXtM3b25jYpVZaih1Mx
         fRoA==
X-Gm-Message-State: AGi0Pua2JXsOIsfWw8js5kkL3Cq5jb/3x8Wv34xCas6uOOuXfzCc0eDB
        z0dhcvj8suf++m6O2mLxUJQ=
X-Google-Smtp-Source: APiQypIrfQvZJT2LwyUWRkkFYRDnJFheak81MJ0TQxqjm4du4jwr6HHNoKxehU7mesYXzZ7gdesZmw==
X-Received: by 2002:a17:902:9892:: with SMTP id s18mr490734plp.321.1586230419618;
        Mon, 06 Apr 2020 20:33:39 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id q71sm12941277pfc.92.2020.04.06.20.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 20:33:38 -0700 (PDT)
Date:   Mon, 6 Apr 2020 20:33:34 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.or>,
        Adrian Reber <adrian@lisas.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH] ns: Fix time_for_children symlink
Message-ID: <20200407033334.GC494464@gmail.com>
References: <a2418c48-ed80-3afe-116e-6611cb799557@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a2418c48-ed80-3afe-116e-6611cb799557@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 03, 2020 at 02:11:39PM +0200, Michael Kerrisk (man-pages) wrote:
> Dmitry, Andrei,
> 
> Looking at the contents of the /proc/PID/ns/time_for_children
> symlink shows an anomaly:
> 
> $ ls -l /proc/self/ns/* |awk '{print $9, $10, $11}'
> ...
> /proc/self/ns/pid -> pid:[4026531836]
> /proc/self/ns/pid_for_children -> pid:[4026531836]
> /proc/self/ns/time -> time:[4026531834]
> /proc/self/ns/time_for_children -> time_for_children:[4026531834]
> /proc/self/ns/user -> user:[4026531837]
> ...
> 
> The reference for 'time_for_children' should be a 'time' namespace,
> just as the reference for 'pid_for_children' is a 'pid' namespace.
> In other words, I think the above time_for_children link should read:
> 
> /proc/self/ns/time_for_children -> time:[4026531834]
> 
> If you agree with this patch, then it should be marked for
> stable@vger.kernel.org.
>

Acked-by: Andrei Vagin <avagin@gmail.com>
 
> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
