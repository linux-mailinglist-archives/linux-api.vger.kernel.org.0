Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254311A0E47
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgDGNYU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 09:24:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGNYT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 09:24:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id v5so3827536wrp.12;
        Tue, 07 Apr 2020 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=iFpX0wEUvG52BzZ7ywOElH5HPg69y7nY2lI1Z/4058E=;
        b=cacTnPy9+5VyruFofPGDS0EkZviISlV1JLgdCFMNWCTpqByHnXd4lVH/kyeuVfLuSk
         bvfNyGjEuGNVoPPya49tYtz6EtEShONcF0OqQvA0jeDctqOz8xa6q1yeNrRr3qEBL9Yh
         7hvfipzfk9hO1Q2MMqweAdpW9NWnPS7Ctl66BdiytK7u/WPq4TYsaTRiiRcIBHgKr2Gc
         jipBHrYGOu5bQ8UeOkEZNKg1o9zAEuSwBVvqxyIBjhV7w29T3EELxn/WomGImtGt/izp
         MhSg1MC8ORnwARxJmrdcZPAV74njOwM0/cZ469gCEQuNB5lHGl4uVHIEqnn27ptt3naf
         F7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=iFpX0wEUvG52BzZ7ywOElH5HPg69y7nY2lI1Z/4058E=;
        b=sPgER/gmhT4IgVZNVeT5DDpH9uBJcmXYLWc9e5ka5kjXzAjSCyLW87uzqKB0WTSkqJ
         gWYCAd2oe6NpfsVj5LYtrZpi4TIGO7aCcAXc5+ZAjocxHNEHUKphHQTacAs6F3bq1vU8
         Kri0lIJWvOMtbBd9ivzstCGAWdJnSHadlCOg9NhEh+8+HZHDjzm5GMukLimqbetVghFV
         cwBH5cY1vSInPE9xCF6+vYNr325J3y3VDtL+Zpz5PU99M0WPgQqYY0nLqGOMhN0QtMeP
         nVj5PkQ6zrTuc6aW/UlHMX/h/Uyg17YCsMGgHnRWLisa34GMzp9k49z1fRqJG/CIESnM
         mStQ==
X-Gm-Message-State: AGi0PuYThowVWyAU3JmWt1/leAA2IS3FRbwv4j2gij9SQapzQxqnIPjB
        sgQAJQOWOmaw2UHBUd2tt0Y=
X-Google-Smtp-Source: APiQypK0r/YazavGUTlIY4JHsTSsbwUAsCWfi9PK6WteZTsCdKSSMHSBnbaRJSuqrJj1PfzveoBnZg==
X-Received: by 2002:adf:e282:: with SMTP id v2mr2772924wri.329.1586265857555;
        Tue, 07 Apr 2020 06:24:17 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id c11sm5696030wrt.24.2020.04.07.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 06:24:16 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrey Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
To:     Andrey Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: A further though on /proc/PID/timens_offsets
Message-ID: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
Date:   Tue, 7 Apr 2020 15:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Dmitry, Andrei,

Quoting the draft time_namespaces manual page:

       Associated with each time namespace are  offsets,  expressed  with
       respect  to  the initial time namespace, that define the values of
       the monotonic and boot-time clocks in that namespace.  These  off‐
       sets  are  exposed  via the file /proc/PID/timens_offsets.  Within
       this file, the offsets are expressed as lines consisting of  three
       space-delimited fields:

           <clock-id> <offset-secs> <offset-nanosecs>

       The  clock-id  identifies the clock whose offsets are being shown.
       This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_BOOT‐
       TIME.

What was the reason for exposing numeric clock IDs in the
timens_offsets file? In API terms, that seems a little ugly.

I think it would have been much nicer if the clocks were defined
symbolically in this file. I.e., that reading the file would have
shown something like

monotonic    x    y
boottime     x    y

And that records similarly with symbolic clock names could have
been written to the file. Was there a reason not to do this?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
