Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9661419C067
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 13:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbgDBLsg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 07:48:36 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37913 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgDBLsf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 07:48:35 -0400
Received: by mail-ed1-f45.google.com with SMTP id e5so3730930edq.5;
        Thu, 02 Apr 2020 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RxotV2BasBbvDbO+1GlHiHB4axKe8obbKqBSI5LDltw=;
        b=LE47gGcLUZhC5oTj/ozqEjBhGttt6rCAqV2WquP8WZ40MALAkDu+mKIkHaE8Z4XON+
         wuTI4XF0sXjFFKT1wBWS2AN4GT4eOv1J8R8hcIev+M0SayeT7WYlkE7EHjvBdvYwsGII
         ++cVAnbt7kx81xXGtTedLv90p/rKXR8m05LUEscNk2pF7O8F793z68AnWwFCp6wFudrc
         InJBdPOz5lZIvwBMHOuF4Uo760ZXRWz5uIZfOGn/EqBGWYTgis92ae5s1biUQ4oNUy1Q
         h74XetJRaRRdBjQ3g8E6IAOWwMPc6sXjMnz2r0+gYDjkwiM0gFhmadrLYShTpB/oQTHa
         BGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RxotV2BasBbvDbO+1GlHiHB4axKe8obbKqBSI5LDltw=;
        b=U4xLW5bCGM9D9OVRIJXiyuJLO26ILOehIhOBwp32vGVt7gOV232I2Jp50UOZDu/hcy
         UAcWUcOJ6mzmRehuYs1mn6hKXdyy2YwM3RIl3F87IdJlyrNnm2WAAE/JjkltbSZU83Kq
         T4UxNFYxjWlRMFsk5uykSCcuOh1VSDSDRuues8W7s8axckW0C9dlWCD5S1nD/MHPS7e1
         RhjKF6JA0eo7S3IVEQ79yYQtJil1fM6ZtqdfIGlzKcuSEheUeA+dvOhhp3xfiqy5rV8t
         iNe7qga2wVPXQ72xdOu6VnvoP7TUq2qJu2LJ0zQz5M6+fwyYyHQOSXLxP1T0Aer51tGq
         IxAA==
X-Gm-Message-State: AGi0PuYW/oQfDPt5B9zKCTrhplXTlsDDe2SGGzIwu6Xa1U0BLR30vKIC
        5A/ix3Ul3L2tQPPVZubfNsI6M2Mj475AghoDyzA=
X-Google-Smtp-Source: APiQypJVdit4ZlmSdtgAAoWqHOXNz+ulV/o6Vk/7lzADjjuo6pa+JLlg3AOtR3qZ2BvvcEnIWHsw3M05XQtKyXn3ltw=
X-Received: by 2002:a17:906:77d3:: with SMTP id m19mr2704365ejn.307.1585828113509;
 Thu, 02 Apr 2020 04:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
 <a225bae5-e342-fee4-b7fa-c3093ca52fa0@gmail.com> <CAKgNAkhzOq2-H8Ka2Dx9ijrVZkaH9cNzKkAENM9hyQx9MBnAKQ@mail.gmail.com>
In-Reply-To: <CAKgNAkhzOq2-H8Ka2Dx9ijrVZkaH9cNzKkAENM9hyQx9MBnAKQ@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 2 Apr 2020 13:48:22 +0200
Message-ID: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
Subject: Re: clock_settime(2) error for non-settable clocks
To:     Eric Rannaud <eric.rannaud@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Cc:     Aleksa Sarai <asarai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Eric,

See also my changes in
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=96d951a401c65525bec0f973946b8dfb24afd670

A textual table in that commit captures most of what I know. Still,
some pieces that you mentioned are not covered. (patches welcome)

Thanks,

Michael
