Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD19F2D49
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfKGLSV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 06:18:21 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:34129 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbfKGLSV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 06:18:21 -0500
Received: by mail-lj1-f180.google.com with SMTP id 139so1839725ljf.1
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 03:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=MCOHv+ahNIiDQ/BEHrruGU6fKZqmxd485sQkrOZcOE4=;
        b=o0mrckry31z5VXVZHl3gFbInLhtUfilLZ5IdygzCHVs48QR3gnHvkrXj3PlCIUmHYe
         7teq7a6xhW0ox/qqYT+G/qTSqfOVyPWRtoMdmOUUIVKwMvC+d/T70u4enJ6USgYkR3yc
         GablOgB3MyH+43qn+Uqid1Qvk5IOHEesi5mtpsSnr6un6ircmTVNfnsD8JJjqxhV7U7x
         NO+u7YmTHxah9wRlPvV/0PZxiNS9Aze3+keAHhLqgAPDyLdn4kwptmHlbkmCUIJwnADF
         YIWBx7F1ESZ7yGm7MBoqrYjViiA0YHpQ6vWcTeDILxKS6RdEOcpFw3qPnq8Q6CxdBKW2
         WCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MCOHv+ahNIiDQ/BEHrruGU6fKZqmxd485sQkrOZcOE4=;
        b=dDFenl9gAb/Tg1R0xEXHV/oklX+AoAe0dFCwZ0us7ZETiq2UCzPF6B0oPX6TqiJ3rk
         nnJRaf60nVzSB3zeMVo4ZtdgEwRl0aBTi8szBASvtqOR2LQiRgniYaLRFNHcd8E6G5hK
         DCQioDZcHFz/X0jaRFP9c8+DhCEI62hZR5bDUVdtZpUGdHInGpwavU43hTafPjBZevPz
         eb31JFpihCe6wINw/mqIToKpAJFcZ44li4yiKp//dzQ3AQT6KatxvQ3XJhpcCwUzbPnu
         pBob3dO20nQDw600pSgTZlwReGD6OrIpA54rzRheyu56OEBas9KgnzLE2mxcRPaktnuE
         QdnA==
X-Gm-Message-State: APjAAAULmXab8VugmlaOEpoR3ODam5icHfBGULtZP4jwV+iaAW9O/jj0
        dUWlcvgoxBbYZIJ7jnKYU05f7ou7rTRuthRGNeC1ypNp
X-Google-Smtp-Source: APXvYqxvzXoL1TFk/hmmCGwLl+vUM2aFhaz95TsH3qIJl+ooeEEz6mmcQSF5O5FEtywh8epwQpmiKQUr+MlRxClFQa4=
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr2009636ljp.119.1573125496949;
 Thu, 07 Nov 2019 03:18:16 -0800 (PST)
MIME-Version: 1.0
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Thu, 7 Nov 2019 13:17:50 +0200
Message-ID: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
Subject: Continuing the UAPI split
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
I'm working on a library that calls syscalls directly to the kernel.
`make hedears_install` is a great command to auto generate the UAPI
headers that are needed to call the kernel.

But the headers are still missing a bunch of defines for flags and structs.

I wanted to know if patches to move more things from `./include/linux`
to `./include/uapi/linux` are welcome (obviously only
typedefs/defines/structs that are required for the syscalls)

I think the UAPI is really close to getting a complete set of things
needed to communicate with the syscalls, but still not quite there. I
would like to push patches whenever I see missing things that my
library needs (that way it will be incrementally and by usage only).

Would love to get feedback.
Thanks,
Elichai.


-- 
PGP: 5607C93B5F86650C
