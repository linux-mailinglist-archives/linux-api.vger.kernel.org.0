Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E5A108CDE
	for <lists+linux-api@lfdr.de>; Mon, 25 Nov 2019 12:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfKYL0f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Nov 2019 06:26:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKYL0f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Nov 2019 06:26:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so17600940wro.5
        for <linux-api@vger.kernel.org>; Mon, 25 Nov 2019 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=gOsW7ulrhFSJlvGJgzch5iEWuSn2aLJsOBIoHfa2J8R5ZcZPNT21kVCpLX2F005KhH
         6RVLxbqVh5n0fO/Yu5v+8GaqAQ9XM2aiKlf7a4mZncYZ+k4ZrbcGcqPKKZUZF+8uE9ad
         a+IjME6Oktm0RDwvpApiA+eEV40Pjcls1r5pU0BR10ESKDjfSGTB4z4WCEnBtHaDGPlZ
         V8Shdxqx+KOAPGCr9uicmqfXNOUfGcCWgF/ol4xCxA2SACIRfn7nHyDIPkhOqef0iB9v
         YFVwZvqga4dwQJmeYwy95Ra8CvE3fRp8TYQimA63FhbXzirALLTsPpDcUM6kmY1XjLB1
         FQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=sNNdlLumemW85mvuR8kF1ZZRz6p6aHDJNWZZG4oSFg9tRSHJ3RoJAj+Ekp0LFS49ML
         SXmnSdOzagpOded+CGcg++C3METC2JGqRttci2ltBo9x5u2rVD/7dZZzb0kGghnn18TZ
         ygkGzwWRzhsNdcF5QTUnhs8N0iQjslmkRSnJIQVYG70o0J4EtqtrfhEBWCJSnq8xOW78
         DWDgyFZXQQ7kvnbjmrGke8nf4FwhsorzSCUIWYb7rBwQE2U6zHyD3AzMpmI55l95gBTp
         rj0RMzi5Qw7GRXMsK9M/Kr9jhpj0lFgsOAiAeoLpmJecEBX4UiFm8dMf2Bn8UOH/bS1k
         8IDQ==
X-Gm-Message-State: APjAAAWvhBTz5jehnRUi5UqSgmjpchgSMCIS2cl4N6/LnFnIrb0AhFdA
        lU8NrDD1RHwMYtiOC0ltmvHK1e1KmaKIY1Dm9Ms=
X-Google-Smtp-Source: APXvYqzjALIYtNSwgPyzre6nWY+7hJQxTyRFJKdqKoZZ+Cf0qb2qwY6OmZo22iKWy8KI2ZV6fI/wcHkzL3CnztSCsqY=
X-Received: by 2002:adf:fec5:: with SMTP id q5mr31515141wrs.293.1574681193175;
 Mon, 25 Nov 2019 03:26:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:81cf:0:0:0:0:0 with HTTP; Mon, 25 Nov 2019 03:26:32
 -0800 (PST)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <abmcchambers@gmail.com>
Date:   Mon, 25 Nov 2019 03:26:32 -0800
Message-ID: <CAKSA5Eqo0--sB0x3JR-0PA9L8RgSS-DWo9P395DpyZKvYnG2kg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

RGVhciBGcmllbmQsDQpJIGFtIEJhcnJpc3RlciBBYnJhaGFtIE1vcnJpc29uLCBEaWQgeW91IHJl
Y2VpdmUgbXkgcHJldmlvdXMgbWVzc2FnZQ0KdG8geW91PyBJIGhhdmUgYW4gaW1wb3J0YW50IGlu
Zm9ybWF0aW9uIGZvciB5b3UgYWJvdXQgeW91ciBpbmhlcml0YW5jZQ0KZnVuZCB3b3J0aCBvZiAo
JDIwLDUwMCwwMDAuMDApIE1pbGxpb24gd2hpY2ggd2FzIGxlZnQgZm9yIHlvdSBieSB5b3VyDQps
YXRlIHJlbGF0aXZlLCBNci4gQ2FybG9zLiBTbyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgZ2V0IGJh
Y2sgdG8gbWUgZm9yDQptb3JlIGRldGFpbHMuDQpUaGFuayB5b3UuDQpCYXJyaXN0ZXIgQWJyYWhh
bSBNb3JyaXNvbi4NCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uDQrQlNC+0YDQvtCz0L7QuSDQtNGA0YPQsywNCtCvINCR0LDRgNGA0LjR
gdGC0LXRgCDQkNCy0YDQsNCw0Lwg0JzQvtGA0YDQuNGB0L7QvSwg0JLRiyDQv9C+0LvRg9GH0LjQ
u9C4INC80L7QtSDQv9GA0LXQtNGL0LTRg9GJ0LXQtSDRgdC+0L7QsdGJ0LXQvdC40LUg0LTQu9GP
DQrQstCw0YE/INCjINC80LXQvdGPINC10YHRgtGMINC00LvRjyDQstCw0YEg0LLQsNC20L3QsNGP
INC40L3RhNC+0YDQvNCw0YbQuNGPINC+INCy0LDRiNC10Lwg0L3QsNGB0LvQtdC00YHRgtCy0LXQ
vdC90L7QvA0K0YTQvtC90LTQtSDQvdCwINGB0YPQvNC80YMgKDIwIDUwMCAwMDAsMDAg0LTQvtC7
0LvQsNGA0L7QsiDQodCo0JApLCDQutC+0YLQvtGA0YvQuSDQvtGB0YLQsNCy0LjQuyDQstCw0Lwg
0LLQsNGIDQrQv9C+0LrQvtC50L3Ri9C5INGA0L7QtNGB0YLQstC10L3QvdC40LosINC80LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEuINCi0LDQuiDRh9GC0L4sINC10YHQu9C4INCy0Ysg0LfQsNC40L3R
gtC10YDQtdGB0L7QstCw0L3RiywNCtGB0LLRj9C20LjRgtC10YHRjCDRgdC+INC80L3QvtC5INC0
0LvRjyDQsdC+0LvQtdC1INC/0L7QtNGA0L7QsdC90L7QuSDQuNC90YTQvtGA0LzQsNGG0LjQuC4N
CtCh0L/QsNGB0LjQsdC+Lg0K0JHQsNGA0YDQuNGB0YLQtdGAINCQ0LLRgNCw0LDQvCDQnNC+0YDR
gNC40YHQvtC9Lg0K
