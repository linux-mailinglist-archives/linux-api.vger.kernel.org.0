Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC1402CFB
	for <lists+linux-api@lfdr.de>; Tue,  7 Sep 2021 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbhIGQkU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Sep 2021 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbhIGQkT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Sep 2021 12:40:19 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9046FC061575
        for <linux-api@vger.kernel.org>; Tue,  7 Sep 2021 09:39:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m11so13724814ioo.6
        for <linux-api@vger.kernel.org>; Tue, 07 Sep 2021 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AQSygVQR7X2p3idaY2kblM6hHvDCfsOME2h6aqCtJ1E=;
        b=J9wKA2u//rt2N18EvKurLQs1GYvrydFPT69DIE8jqvK5Vpht4Wxy/HB56V4oPgYinq
         1//uIpWNYkyykf3cXw5GwzRzSNBA+8ixPI20f3Blmalav1y3CGExTXh+JLs3eJ61ivv1
         b7cbY3MkyIVaPUf3yyqPvxK6OBqnt2Cx5QiOPZnVPHJ4y1uVfgf5lqn5o6WpgeBPe1ud
         4uEZklUCj9aLkMN2ftXy1kyT6d7yoTDwgmnBnKu1X1GkXW0/3vSNctlhW4AjF3nKvLmE
         VCVNmGGna35wLb6uHqq+BGApQC92/5qYkNnbTaNlntssGOPxgOtbawJp2Vq8nX1fjaYg
         dmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=AQSygVQR7X2p3idaY2kblM6hHvDCfsOME2h6aqCtJ1E=;
        b=dwm4vJev+0eD9QPVhV6zvjdI/rJVzDZWymruiWGS0JT3vUP+M7Jkt6r2BWf3QRZ+pI
         O13gU+HL8kXUJZzYPLIBI2XLTTMHNEaA6Hl0IAeUBHT9etMekRsXcrG8DHCxb4XfNE1y
         kCkszNmGnI4PmDue8mZAixGLhwqJVkvn6mEm5FhFAQ+XfamKlC6aTVMYWz9Roa7ufWJL
         pQqBYCCF3YrdgxJxNbZJZL8kpFDJ774vwP8G3LxKFhvVCCEMdgHo/H3dpDmrG2Tj7+i0
         fv7yEeew1UJ57G7ndIfEaR5VgBWjV0P+vnzBVlYvf3v/0TpX3wXq3TwSe7ZCR+X6vFG2
         MJLw==
X-Gm-Message-State: AOAM532SyfLriEakX1ySINFXKqYh6psZmb8ZafIGVObV14JlYRo4N8X9
        ZBPnsr3oGgM4p4ST6YkrYJhyOZUmOpAMj13RltE=
X-Google-Smtp-Source: ABdhPJwS84Fo64mI7QO8+1acNeBj59dyW9yjpUGkzz1OJsk0mCniz8QEjs7KXwrHzcuHXAat/C78ddMIVImiZHvfSWU=
X-Received: by 2002:a6b:b842:: with SMTP id i63mr12245025iof.115.1631032752746;
 Tue, 07 Sep 2021 09:39:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:44c2:0:0:0:0:0 with HTTP; Tue, 7 Sep 2021 09:39:10 -0700 (PDT)
Reply-To: shawnhayden424@gmail.com
From:   Shawn Hayden <sophiebrandon679@gmail.com>
Date:   Tue, 7 Sep 2021 17:39:10 +0100
Message-ID: <CAFXeZCQZ_sdiz6_9VN6O5Ekwvq+VhNFQUVpGf5umuNvpq6OzGA@mail.gmail.com>
Subject: =?UTF-8?B?Q2hhcml0eS/UstWh1oDVpdWj1bjWgNWu1bjWgtWp1bXVuNaC1bYgQmFyZWdvcnRzdXQ=?=
        =?UTF-8?B?4oCZeXVu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

1Y3Vq9aA1aXVrNWrINWo1bbVr9Wl1oAsDQoNCtS11b0g1LHVvtW91b/WgNWh1azVq9Wh1bXVqyDW
hNWh1bLVodaE1aHWgdWrINWl1bQsINWh1brWgNW41oLVtCDVpdW0INSx1YTVhiAt1bjWgtW0INaH
INW81avVpdWs1anVuNaAINWl1bQgMzUg1b/VodaA1b7VoQ0K1aHVt9Wt1aHVv9Wh1bbWhNWh1bXV
q9W2INaD1bjWgNWx1bjVvg0K1oPVuNaA1bHVodW81bjWgtWp1bXVuNaC1bY6INWO1aXWgNW71aXW
gNW9INW+1aHWgNWh1a/VvtWl1oHVqyBDb3ZpZC0xOSDVvtWr1oDVuNaC1b3VuNW+INaHINWk1oDV
oSDVutWh1b/Vs9Wh1bzVuNW+DQrVq9W0INW/1aHWgNWr1oTVqywg1aXVvSDVudWl1bQg1a/VodaA
1a7VuNaC1bQsINW41oAg1a/VodaA1bjVsiDVpdW0INWj1bjVtdWh1b/Wh9Wl1awg1b3VoTog1LXV
vSDVqdWp1b7VodWu1bbVqyDVv9Wh1a8g1aXVtCDVpdWy1aXVrCDVoQ0K1bTVqyDWhNWh1bbVqyDW
hdaALCDWhyDVpdW9INW51aXVtCDVr9Wh1oDVuNWyINWv1bXVodW21oTVvSDVo9W21aXVrCDWg9W4
1bLVuNW+OiDUtdW9INWv1aHWgNW41bIg1aXVtCA1NSDVtNWr1azVq9W41bYNCtSx1YTVhiDVpNW4
1azVodaAINW21b7Vq9aA1aHVotWl1oDVpdWsINWi1aHWgNWl1aPVuNaA1a7VuNaC1anVtdWh1bbV
qCwNCtWw1aHVv9Wv1aHVutWl1b0g1aHVstaE1aHVv9W21aXWgNWr1bYg1oXVo9W21aXVrNW41oIg
1bDVodW01aHWgDog1LHVttaB1bXVodWsINW/1aHWgNWrINWl1b0g1a/VuNaA1oHWgNWl1oHVqyDV
r9W21bjVu9W9DQrWhNWh1bLWgdWv1aXVstWr1oEsINaHINWr1bQg1bTVq9Wh1a8g1bjWgNWk1avV
tiDWhNaA1bjVttWr1a8g1bDVq9W+1aHVttWkINWnDQrVrdWh1bLVodW01bjVrCwg1bjVviDVtNW9
1a3VpdaBINWr1bQg1b/WgNWh1bTVodWk1oDVodWuINWi1bjVrNW41oAg1bTVq9W71bjWgdW21aXW
gNWoOg0K1YDVq9W+1aHVttWkINWw1avVvtWh1bbVpCDVodW21a/VuNWy1bbVuNaC1bQg1brVodW8
1a/VodWuINWdINWh1bzVodW21oEg1aPVuNW11aHVv9aH1bTVodW2INWw1bjWgtW11b0g1bjWgtW2
1aXVttWh1azVuNaCLCDVtNWh1bLVqdW41oLVtCDVpdW0DQrVpNW41oIg1avVttWxINaF1aPVttWl
1oHVq9aAINWv1aHVv9Wh1oDVpdWsINWr1bQg1b7VpdaA1bvVq9W2INaB1aHVttWv1bjWgtWp1bXV
uNaC1bbVqDog1Y3VoSDWgdWh1bbVr9W41oLVqdW11bjWgtW2INWnLCDVuNaA1agNCtWv1a7VodW8
1aHVtdWrINWr1bbVsQ0K1bjWgNW61aXVvSDVodWy1aHVudWh1bbWhCDUsdW91b/VrtW41oLVtiDV
q9W0INWw1bjVo9W41oIg1ocg1avVtCDVtNWl1bLWhNWl1oDVqyDVqdW41bLVuNaC1anVtdWh1bYg
1bDVodW01aHWgDog1LXVqdWlIOKAi+KAi9W61aHVv9aA1aHVvdW/INWl1oQNCtaHINW61aHVv9aA
1aHVvdW/INWnINaF1aPVttWl1awsINWt1bbVpNaA1bjWgtW0INWl1bQg1brVodW/1aHVvdWt1aHV
ttWl1oQg1avVttWxLCDWhyDVpdW9INWx1aXVpiDVtNWh1bbWgNWh1bTVodW91bbVpdaADQrVr9W/
1aHVtDog1LXVvSDVo9Wr1b/VpdW0LCDVuNaAINWl1b0NCtWv1aHWgNW41bIg1acg1b7VvdW/1aHV
sNWl1awg1oTVpdWmOiDVldWj1bbVpdaB1aXWhCwg1a3VttWk1oDVuNaC1bQg1aXVtC4NCg0K1YDV
odaA1aPVodW21oTVttWl1oDVuNW+Lg0KDQrVh9W41bYg1YDVpdW11aTVpdW2Lg0KDQpTaXJlbGkg
eW5rZXIsDQoNClllcyBBdnN0cmFsaWF5aSBr4oCZYWdoYWvigJlhdHPigJlpIHllbSwgYXBydW0g
eWVtIEFNTiAtdW0geWV2IHJyaXllbHTigJl2b3INCnllbSAzNSB0YXJ2YSBhc2hraGF0YW5r4oCZ
YXlpbiBw4oCZdm9yZHpvdg0KcOKAmXZvcmR6YXJydXTigJl5dW46IFZlcmplcnMgdmFyYWt2ZXRz
4oCZaSBDb3ZpZC0xOSB2aXJ1c292IHlldiBkcmEgcGF0Y2hhcnJvdg0KaW0gdGFyaWvigJlpLCB5
ZXMgY2jigJllbSBrYXJ0c3VtLCB2b3Iga2Fyb2doIHllbSBnb3lhdGV2ZWwgc2E6IFllcw0KdOKA
mXTigJl2YXRzbmkgdGFrIHllbSB5ZWdoZWwgYQ0KbWkga+KAmWFuaSBvciwgeWV2IHllcyBjaOKA
mWVtIGthcm9naCBreWFua+KAmXMgZ25lbCBw4oCZdm9naG92OiBZZXMga2Fyb2doDQp5ZW0gNTUg
bWlsaW9uIEFNTiBkb2xhciBudmlyYWJlcmVsIGJhcmVnb3J0c3V04oCZeWFueSwNCmhhdGthcGVz
IGFnaGvigJlhdG5lcmluIG9nbmVsdSBoYW1hcjogQW50c+KAmXlhbCB0YXJpIHllcyBrb3J0c+KA
mXJldHPigJlpDQprbm9qcyBr4oCZYWdodHPigJlrZWdoaXRz4oCZLCB5ZXYgaW0gbWlhayB2b3Jk
aW4ga+KAmXJvbmlrIGhpdmFuZCBlDQpraGFnaGFtb2wsIG92IG1za2hldHPigJkgaW0gdHJhbWFk
cmF0cyBib2xvciBtaWpvdHPigJluZXJ5Og0KSGl2YW5kIGhpdmFuZCBhbmtvZ2hudW0gcGFycmth
dHMg1Z0gYXJyYW50c+KAmSBnb3lhdGV2bWFuIGh1eXMgdW5lbmFsdSwNCm1hZ2h04oCZdW0geWVt
DQpkdSBpbmR6IG9nbmV0c+KAmWlyIGthdGFyZWwgaW0gdmVyamluIHRz4oCZYW5rdXTigJl5dW55
OiBTYSB0c+KAmWFua3V04oCZeXVuIGUsDQp2b3J5IGt0c2FycmF5aSBpbmR6DQp2b3JwZXMgYWdo
YWNo4oCZYW5r4oCZIEFzdHRzdW4gaW0gaG9ndSB5ZXYgaW0gbWVnaGvigJllcmkgdOKAmXZvZ2h1
dOKAmXlhbg0KaGFtYXI6IFlldOKAmWUg4oCL4oCLcGF0cmFzdCB5ZWvigJkNCnlldiBwYXRyYXN0
IGUgb2duZWwsIGtobmRydW0geWVtIHBhdGFza2hhbmVr4oCZIGluZHosIHlldiB5ZXMgZHpleg0K
bWFucmFtYXNuZXIga3RhbTogWWVzIGdpdGVtLCB2b3IgeWVzDQprYXJvZ2ggZSB2c3RhaGVsIGvi
gJllejogT2duZXRz4oCZZWvigJksIGtobmRydW0geWVtLg0KDQpIYXJnYW5r4oCZbmVyb3YuDQoN
ClNob24gSGV5ZGVuLg0KDQoNCg0KRGVhciBmcmllbmQsDQoNCkkgYW0gYW4gQXVzdHJhbGlhbiBj
aXRpemVuIGxpdmluZyBpbiB0aGUgVVNBIGFuZCBhIHJlYWx0b3Igd2l0aCAzNSB5ZWFycyBvZg0K
ZXhwZXJpZW5jZS4gSSByZWNlbnRseSBiZWNhbWUgaW5mZWN0ZWQgd2l0aCB0aGUgQ292aWQtMTkg
dmlydXMgYW5kIGR1ZSB0bw0KbXkgYWdlLCBJIGRvbid0IHRoaW5rIEkgY2FuIHN1cnZpdmUgdGhp
cy4gSSBoYXZlIGJlZW4gdW5kZXIgb3h5Z2VuIGZvciBhDQpmZXcgZGF5cyBhbmQgSSBjYW4ndCBi
dXkgbXkgbGlmZSB3aXRoIG1vbmV5LiBJIGNvdWxkIGRvbmF0ZSA1NW1pbGxpb24NClVTRCB0byBj
aGFyaXR5LA0KZXNwZWNpYWxseSB0byBoZWxwIHRoZSBwb29yLiBMYXN0IHllYXIgSSBsb3N0IG15
IHdpZmUgdG8gY2FuY2VyIGFuZCBteQ0Kb25seSBzb24gaXMgYSBjaHJvbmljDQpnYW1ibGVyIHdo
byBzcXVhbmRlcmVkIGFsbCB0aGUgZnVuZHMgSSBnYXZlIHRvIGhpbS4NCkx5aW5nIGluIG15IHNp
Y2sgYmVkLCB3aXRoIG5vIGhvcGUgb2Ygc3Vydml2YWwsIEkgd2lzaA0KeW91IGhlbHBlZCBtZSBm
dWxmaWxsIG15IGxhc3Qgd2lzaC4gVGhpcyBpcyBhIHdpc2ggdGhhdCB3aWxsIHNlcnZlIG1lDQph
cyBhIHBsZWEgdG8gR29kIGZvciBteSBzb3VsIGFuZCBteSBmb3JnaXZlbmVzcyBvZiBzaW5zLiBJ
ZiB5b3UgYXJlIHdpbGxpbmcNCmFuZCByZWFkeSB0byBoZWxwLCBwbGVhc2UgYW5zd2VyIG1lIGFu
ZCBJIHdpbGwgZ2l2ZSB5b3UgZGV0YWlscy4gSSBrbm93IEkNCmNhbiB0cnVzdCB5b3UuIEhlbHAg
bWUgcGxlYXNlLg0KDQpLaW5kIHJlZ2FyZHMsDQoNClNoYXduIEhheWRlbi4NCg==
