Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C834E4565
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405659AbfJYINi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 04:13:38 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36957 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389290AbfJYINh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 04:13:37 -0400
Received: by mail-ed1-f45.google.com with SMTP id e12so1027317edr.4;
        Fri, 25 Oct 2019 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=ufv5OzTW6Ho2U725k1EQBRKapEBTyRGxkO/CDS+nmDM=;
        b=cpH3GSYhIpKHYeKELNj+uIbhP3LamQQnR9AifXa2wEQZdJBKWsuQ6l9qNDHnS/p8ZH
         4m/fPIZxAFhIdzGW+9MeGudMMTSpzxRIA4yZOkKugoe/VMm5f7OW0Rks+9VdYpUuspUI
         RTx0Ta8ttkSPT3H6b9YbPtokGd/5NkGwdLaKcjXD6MkCUbZdU0DHOiEl0hIMVTff6VVn
         mCZGNihu5+vQTvqh5eGdVo6jmaDwnaNmH9gncFOR9jMk0JEKG9D38KJvQo/eInMuMrNB
         Hp+/m5UIZpav4b3eTtydp5jWSZKeBkX3hnqquXsST2HMW4YyEvLnCA8AQ4NJS+KadBVV
         vxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ufv5OzTW6Ho2U725k1EQBRKapEBTyRGxkO/CDS+nmDM=;
        b=aPExh2JJCGNlIIHcSJWyExGvRDnUbZWL1ezC4+2jT8h9AoaGv5ASCoix7L40/pAyIo
         9BBzpAlBmi5udVmQ1mcH3gLI7onJKyMY8RZcBPc9/4ajS/b2/6y6KFcgo1aW53WMA12L
         jBb/z83YK0CfeO8+BJz2hvrh96YPF13rP0une4iemajsoxT2x56fKr4/lqWXitpbh6AG
         G2RW7lHIc/H1TXzyCuTsFdwjD0vs3QAhkcG4u3SWvWky+sAv2Bzsl9BMYXI2ltgJBZIs
         DztvjliUM3xaxxZCSoZDqK6N4Nfl1kdg7FTRtTWyEIpjIg6LZ1nyfPSET37/Uer0oGzt
         +UxQ==
X-Gm-Message-State: APjAAAUyjr8kSk7sFWU/UPauOyxbrxAJKr3jxyiv8e8EbD9jdRPqyI3V
        8Mf/pJVbaQtKOHHuF+Yw4swNyIknuLSr7oqYar8=
X-Google-Smtp-Source: APXvYqyU5T85XP8ucdsMs0oMCAA8CN3tZn1b0/m7RFVtzVk03CIHFZ/8UebfsvosA3bdTYb/+chbuJOQ+0cID2rn0tQ=
X-Received: by 2002:aa7:d60c:: with SMTP id c12mr1340807edr.14.1571991214302;
 Fri, 25 Oct 2019 01:13:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 25 Oct 2019 10:13:23 +0200
Message-ID: <CAKgNAkgKX1Z6Uns3pAvXe-JMSmWqo2PrqeoS65aEriZsV35QmA@mail.gmail.com>
Subject: clone3() example code
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Christian,

Do you have some example user-space code somewhere that illustrates
calling clone3(). I'm looking at how we might document that system
call in the manual page, and some example code to play with would be
useful at this point. (I already have a simple working test program,
but probably you have something better.)

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
