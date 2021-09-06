Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948EE401686
	for <lists+linux-api@lfdr.de>; Mon,  6 Sep 2021 08:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhIFGm5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Sep 2021 02:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbhIFGm5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Sep 2021 02:42:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05DC06175F
        for <linux-api@vger.kernel.org>; Sun,  5 Sep 2021 23:41:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x6so8087237wrv.13
        for <linux-api@vger.kernel.org>; Sun, 05 Sep 2021 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9ZKBQ6Qo+MKbRqA4C0CUyn4v2spzBO/uH3YajAUeuHc=;
        b=WrxXPTSexnqL9ywJmzn29EAd7m3zOxJI9r9q5J3R101rdaArwAA0ep2fVZRzubhJUe
         pJsKDflQ6zYIy3POZz+IcQbUisMU5vPhHMJ8lWf8qkPsd26d+g7xT+vpdAL8nUGB+jIr
         +oVjS8NOiSV+FVJl+FxgFK9n76oa2tBEoLBTTH3MzyqILrp4HT7WZ7sopFdbhbXYCGwx
         +Yd50SwwpSjwR2tPgENMUXdWbzGiUzc40ee3Wzh7KSyr73NO/THLq5A6dBFWmDlCxMJ/
         QYt2w5KTSo3h/LSVYkz1mwuL0Gl17xvzMinqfFIf3h4XLLmJEb/pivhx8etbey9PRZLq
         dmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9ZKBQ6Qo+MKbRqA4C0CUyn4v2spzBO/uH3YajAUeuHc=;
        b=f+m0vyA6KU3Jwy4AUvo2Ss3F3AGft/wL3hDaGXbOCVqQKMUlxNI7qnzzJZcfL7d7gd
         G0pXC6l3IjDq7qblkbEKI3a7dKyxaqe98g2iRPtQo73BaqOVkinjjdXaRBnR0i1aSfX5
         5ORtNq6CIjhF+CzL71mN8Ka9MbOpBQeum+aSEtZknqP+D64aHad8+SUlkyavFrryZ+lq
         OoTtlFxZMEVRhCUHjDPo2app0LXaFThCFXndM5gEEG0pWlbX5MYb9hjaG99kGWgsqEUw
         PtJEQ0nfVuIMMAx4DIP+OD+tua0hyNYlei9FBLGB7TUgRERy/wH0ZghXIgjmJZldqsfZ
         xEwA==
X-Gm-Message-State: AOAM532tOfcKu/XwAwYFvf+kLUJtGvMkiCedyD3EZsmx/eIPIQQsSnXG
        J9n81jRxdbYscx1DG8q1WTohKG143+m3irNT2ME=
X-Google-Smtp-Source: ABdhPJzZ3mZbr/OrWTb0N/GHJVydPgMaL50t4Xg3CrXMleDnFpRQ6fr9wVjfN7uwN/IUbBtNnHtdbKIjd+hL9PvzZS8=
X-Received: by 2002:adf:e0cd:: with SMTP id m13mr11450350wri.137.1630910510922;
 Sun, 05 Sep 2021 23:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:ac89:0:0:0:0:0 with HTTP; Sun, 5 Sep 2021 23:41:48 -0700 (PDT)
Reply-To: michaelrachid7@gmail.com
From:   Michael Rachid <davidbaldwin378@gmail.com>
Date:   Mon, 6 Sep 2021 07:41:48 +0100
Message-ID: <CAH6Vp6nXS5dh2XVRtgLKAa3rtWHXwe7uXyd2ituVQKjSfHwPiQ@mail.gmail.com>
Subject: =?UTF-8?B?UHJvcG9zYWwgLyDUsdW81aHVu9Wh1oDVr9W41oLVqdW11bjWgtW2IEFycmFqYXJrdXQ=?=
        =?UTF-8?B?4oCZeXVu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

1Y3Vq9aA1aXVrNWrINWo1bbVr9Wl1oAsDQoNCtS11b0g1aPWgNW41oLVtCDVpdW0INWx1aXVpiDV
q9W0INWi1avVptW21aXVvSDVodW81aHVu9Wh1oDVr9WrINW01aHVvdWr1bYg1b/VpdWy1aXVr9Wh
1oHVttWl1azVuNaCINWw1aHVtNWh1oAsINW41oDVqCDVpdW9DQrVr9aB1aHVttWv1aHVttWh1bXV
qyDVrNW41oLVrtWl1awg1bHVpdWmINWw1aXVvzoNCtWG1aXWgNWj1oDVodW+1b7VodWuINWnINWw
1avVvdW41oLVtiDVtNWr1azVq9W41bYg1aTVuNWs1aHWgDog1YDVodW01bjVptW+1aHVriDVpdWy
1aXWhCwg1bjWgCDVodW01aXVtiDVq9W21bkg1oXWgNWr1bbVodWv1aHVtg0K1acg1ocg1aHVvNWh
1bbWgSDVvNWr1b3Vr9Wl1oDVqzoNCtWN1avWgNW41b4g1bbVt9Wl1oQg1bHVpdaAINWw1aXVv9Wh
1oTWgNaE1oDVuNaC1anVtdW41oLVttWoOg0KDQrVhNWh1bXWhNWsINWM1aHVudWr1aQuDQpTaXJl
bGkgeW5rZXIsDQoNClllcyBncnVtIHllbSBkemV6IGltIGJpem5lcyBhcnJhamFya2kgbWFzaW4g
dGVnaGVrYXRz4oCZbmVsdSBoYW1hciwgdm9yeQ0KeWVzIGt0c+KAmWFua2FuYXlpIGx1dHNlbCBk
emV6IGhldDoNCk5lcmdyYXZ2YXRzIGUgaGlzdW4gbWlsaW9uIGRvbGFyOiBIYW1venZhdHMgeWVn
aGVr4oCZLCB2b3IgYW1lbiBpbmNo4oCZDQpvcmluYWthbiBlIHlldiBhcnJhbnRz4oCZIHJyaXNr
ZXJpOg0KU2lyb3YgbnNoZWvigJkgZHplciBoZXRha+KAmXJr4oCZcnV04oCZeXVueToNCg0KTWF5
a+KAmWwgUnJhY2jigJlpZC4NCg0KDQoNCkRlYXIgZnJpZW5kLA0KDQpJIHdyaXRlIHRvIGluZm9y
bSB5b3UgYWJvdXQgYSBidXNpbmVzcyBwcm9wb3NhbCBJIGhhdmUgd2hpY2ggSSB3b3VsZA0KbGlr
ZSB0byBoYW5kbGUgd2l0aCB5b3UuDQpGaWZ0eSBtaWxsaW9uIGRvbGxhcnMgaXMgaW52b2x2ZWQu
IEJlIHJlc3QgYXNzdXJlZCB0aGF0IGV2ZXJ5dGhpbmcgaXMNCmxlZ2FsIGFuZCByaXNrIGZyZWUu
DQpLaW5kbHkgaW5kaWNhdGUgeW91ciBpbnRlcmVzdC4NCg0KTWljaGFlbCBSYWNoaWQuDQo=
